resource "aws_lambda_event_source_mapping" "event_sqs_trigger" {
  for_each = {
    for name in keys(aws_sqs_queue.queues) : name => {
      queue_arn    = aws_sqs_queue.queues[name].arn
      function_arn = aws_lambda_function.functions[name].arn
    }
  }
  event_source_arn                    = each.value.queue_arn
  function_name                       = each.value.function_arn
  enabled                             = true
  batch_size                          = 10
  maximum_batching_window_in_seconds = 5
}
