data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/functions/scheduler-trigger/lambda_function.py"
  output_path = "${path.module}/functions/archived/scheduler-trigger-package.zip"
}
