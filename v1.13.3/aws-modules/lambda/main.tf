resource "aws_s3_object" "lambda_artifact" {
  count        = length(var.function_names) 
  bucket       = var.bucket_name
  key          =  var.s3_key
  source       = var.source
  tags         = merge(var.tags,{ 
  Environment  = var.environment
  Function     = var.function_names[count.index]
  }
}

resource "aws_lambda_function" "lambda_functions" {
  for_each = { for i, name in var.function_names : name => i }

  function_name    = each.key
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handlers[each.value]
  runtime          = var.runtimes[each.value]
  timeout          = var.timeout[each.value]
  memory_size      = var.memory_size[each.value]
  s3_bucket        = var.bucket_name 
  s3_key           = var.s3_key[each.key] 
  tags             = merge(var.tags, {"FunctionName" = each.key})
  environment {
    variables      = var.use_as_artifact_bucket ?  var.environment_variables[each.value] : null 
  }
}



