resource "aws_lambda_event_source_mapping" "event_sqs_trigger" {
  for_each = var.lambda_sqs_mappings
  event_source_arn                      = each.value.queue_arn
  function_name                         = each.value.function_arn
  enabled                               = true
  batch_size                            = 10
  maximum_batching_window_in_seconds   = 5
}
