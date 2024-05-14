variable "app_name" {
  type    = string
  default = "dummy"
}

variable "env_name" {
  type    = string
  default = "test"
}

variable "lambda_exec_role" {
  type = string
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
  default = "cron(35 00 * 5-6 ? 2024)"
}

variable "scheduler_exec_role" {
  type = string
}
