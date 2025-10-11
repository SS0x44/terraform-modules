locals {
  topic_name = zipmap(var.topic_names, var.topic_names)
}

resource "aws_sns_topic" "notification_topic" {
  for_each = local.topic_name
  name         = each.key
  display_name = each.value
}
