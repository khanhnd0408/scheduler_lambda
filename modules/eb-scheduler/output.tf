output "scheduler_group_id" {
  value = aws_scheduler_schedule_group.this.id
  description = "Name of the schedule group"
}

output "scheduler_group_arn" {
  value = aws_scheduler_schedule_group.this.arn
  description = "ARN of the schedule group"
}

output "scheduler_group_create_date" {
  value = aws_scheduler_schedule_group.this.creation_date
  description = "Time at which the schedule group was created"
}

output "scheduler_group_last_modify" {
  value = aws_scheduler_schedule_group.this.last_modification_date
  description = "Time at which the schedule group was last modified"
}

output "scheduler_group_state" {
  value = aws_scheduler_schedule_group.this.state
  description = "State of the schedule group"
}

output "scheduler_tags" {
  value = aws_scheduler_schedule_group.this.tags
  description = "Map of tags assigned to the resource, including those inherited from the provider"
}

output "scheduler_id" {
  value = aws_scheduler_schedule.this.id
  description = "Name of the schedule"
}

output "scheduler_arn" {
  value = aws_scheduler_schedule.this.arn
  description = "ARN of the schedule"
}
