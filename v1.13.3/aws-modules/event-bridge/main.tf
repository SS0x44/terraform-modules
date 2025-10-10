resource "aws_lambda_event_source_mapping" "event_sqs_trigger" {
  event_source_arn  = aws_sqs_queue.aws_queue.arn
  function_name     = aws_lambda_function.lambda_functions.arn
  enabled           = true
  batch_size        = 10                     
  maximum_batching_window_in_seconds = 5    
}
