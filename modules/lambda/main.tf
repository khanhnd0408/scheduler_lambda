resource "aws_lambda_function" "this" {
  filename      = var.absolute_package_path
  function_name = var.function_name
  role          = var.exec_lambda_role
  handler       = var.function_handler

  source_code_hash = var.package_hash

  runtime = var.runtime
  architectures = var.architectures

  environment {
    variables = var.env_parameters
  }

  tags = var.tags
}
