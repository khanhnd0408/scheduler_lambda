variable "app_name" {
  type    = string
  default = "dummy"
}

variable "env_name" {
  type    = string
  default = "test"
}

variable "lambda_runtime" {
  type = string
}

variable "lambda_handler" {
  type = string
}

variable "lambda_architectures" {
  type = list(string)
}

variable "schedule_expression" {
  type = string
  default = "cron(47 14 * 5-6 ? 2024)"
}
