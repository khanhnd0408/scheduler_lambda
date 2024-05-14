resource "aws_scheduler_schedule_group" "this" {
  name = var.scheduler_group_name
  tags = var.scheudler_group_tags
}

resource "aws_scheduler_schedule" "this" {
  name       = var.scheduler_name
  group_name = var.scheduler_group_name

  flexible_time_window {
    mode = "OFF"
  }
  schedule_expression_timezone = var.timezone
  schedule_expression = var.cron_base_expression

  target {
    arn      = var.consumer_arn
    role_arn = var.exec_consumer_role
  }
}
