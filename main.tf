module "scheduler" {
  source = "./modules/eb-scheduler"

  scheduler_group_name = "${var.app_name}-${var.env_name}-scheduler-group"
  scheduler_name = "${var.app_name}-${var.env_name}-scheduler"

  cron_base_expression = var.schedule_expression
  consumer_arn = module.auto_function.function_arn
  exec_consumer_role = var.scheduler_exec_role
}

module "auto_function" {
  source = "./modules/lambda"

  absolute_package_path = data.archive_file.lambda.output_path
  function_name         = "${var.app_name}-${var.env_name}-trigger-function"
  exec_lambda_role      = var.lambda_exec_role
  function_handler      = var.lambda_handler

  package_hash  = data.archive_file.lambda.output_base64sha256
  runtime       = var.lambda_runtime
  architectures = var.lambda_architectures
}
