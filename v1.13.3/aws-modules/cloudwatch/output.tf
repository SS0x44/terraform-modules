output "cloudwatch_alarm_arns" {
  value = { for name, alarm in aws_cloudwatch_metric_alarm.alarms : name => alarm.arn }
}
