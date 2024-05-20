module "scheduler" {
  source = "./modules/eb-scheduler"

  scheduler_group_name = "${var.app_name}-${var.env_name}-scheduler-group"
  scheduler_name       = "${var.app_name}-${var.env_name}-scheduler"

  cron_base_expression = var.schedule_expression
  consumer_arn         = module.auto_function.function_arn
  exec_consumer_role   = module.scheduler_role.role_arn
}

module "auto_function" {
  source = "./modules/lambda"

  absolute_package_path = data.archive_file.lambda.output_path
  function_name         = "${var.app_name}-${var.env_name}-trigger-function"
  exec_lambda_role      = module.lambda_role.role_arn
  function_handler      = var.lambda_handler

  package_hash  = data.archive_file.lambda.output_base64sha256
  runtime       = var.lambda_runtime
  architectures = var.lambda_architectures
}

module "scheduler_policy" {
  source = "./modules/policy"

  policy_name = "${var.app_name}-${var.env_name}-scheduler-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction"
        ],
        "Resource" : [
          module.auto_function.function_arn,
          "${module.auto_function.function_arn}:*"
        ]
      }
    ]
  })
  policy_tags = {}
}

module "scheduler_role" {
  source = "./modules/role"

  role_name            = "${var.app_name}-${var.env_name}-scheduler-role"
  trusted_role_service = "scheduler.amazonaws.com"
  attach_policies_arn  = [module.scheduler_policy.policy_arn]
}

module "lambda_dms_policy" {
  source = "./modules/policy"

  policy_name = "${var.app_name}-${var.env_name}-dms-trigger-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowStartTask",
        "Effect" : "Allow",
        "Action" : [
          "dms:StartReplicationTask"
        ],
        "Resource" : "arn:aws:dms:ap-southeast-1:891377195263:task:*"
      },
      {
        "Sid" : "AllowDescribeTask",
        "Effect" : "Allow",
        "Action" : [
          "dms:DescribeReplicationTasks"
        ],
        "Resource" : "arn:aws:dms:ap-southeast-1:891377195263:*:*"
      }
    ]
  })
  policy_tags = {}
}

module "lambda_exec_policy" {
  source = "./modules/policy"

  policy_name = "${var.app_name}-${var.env_name}-exec-lambda-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })
  policy_tags = {}
}

module "lambda_role" {
  source = "./modules/role"

  role_name            = "${var.app_name}-${var.env_name}-dms-trigger-role"
  trusted_role_service = "lambda.amazonaws.com"
  attach_policies_arn  = [module.lambda_exec_policy.policy_arn, module.lambda_dms_policy.policy_arn]
}
