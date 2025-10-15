resource "aws_sqs_queue" "sqs_queues" {
  for_each = local.queues

  name                      = each.key
  delay_seconds             = each.value.delay_seconds
  max_message_size          = each.value.max_message_size
  message_retention_seconds = each.value.message_retention_seconds
  visibility_timeout_seconds = each.value.visibility_timeout_seconds
  receive_wait_time_seconds = each.value.receive_wait_time_seconds
}
