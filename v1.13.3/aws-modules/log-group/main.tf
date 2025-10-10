resource "aws_cloudwatch_log_group" "lambda_logs" {
  for_each = aws_lambda_function.lambda_functions

  name              = "/aws/lambda/${each.value.function_name}"
  retention_in_days = var.retention_in_days
  tags              = var.tags
}

