output "sqs_queue_urls" {
  value = { for queue_name, _ in local.queue_configs : queue_name => aws_sqs_queue.queues[queue_name].url }
}

output "sqs_queue_arns" {
  value = { for queue_name, _ in local.queue_configs : queue_name => aws_sqs_queue.queues[queue_name].arn }
}
