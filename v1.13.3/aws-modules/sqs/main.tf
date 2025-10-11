locals { queue_configs = { for q in var.sqs_queues : q.name => q } }

resource "aws_sqs_queue" "queues" {
  for_each                    = local.queue_configs
  name                        = each.value.name
  delay_seconds               = each.value.delay_seconds
  max_message_size            = each.value.max_message_size
  message_retention_seconds   = each.value.message_retention
  visibility_timeout_seconds  = each.value.visibility_timeout
  receive_wait_time_seconds   = each.value.receive_wait_time
  tags                        = merge( var.tags,{ Name  = each.value.name})
}

