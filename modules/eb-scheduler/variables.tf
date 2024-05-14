variable "scheduler_group_name" {
  type = string
  default = ""
}

variable "scheudler_group_tags" {
  type = map
  default = {}
}

variable "scheduler_name" {
  type = string
  default = ""
}

variable "cron_base_expression" {
  type = string
}

variable "consumer_arn" {
  type = string
}

variable "exec_consumer_role" {
  type = string
}

variable "timezone" {
  type = string
  default = "Asia/Saigon"
}
