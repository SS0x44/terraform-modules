output "sns_topic_arns" {
  value = { for topic_name, topic in aws_sns_topic.notification_topic : topic_name => topic.arn }
}
