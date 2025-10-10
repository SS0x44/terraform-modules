variable "lambda_sqs_mappings" {
  type = map(object({
    function_arn = string
    queue_arn    = string
  }))
}
