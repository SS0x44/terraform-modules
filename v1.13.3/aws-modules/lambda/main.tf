locals {
  functions = { for i, name in var.function_names : name => i }
}

resource "aws_s3_object" "lambda_artifact" {
  for_each     = local.functions 
  s3_bucket    = var.bucket_name
  key          = "ingestion/${each.key}.zip"        
  source       = "artifact/${each.key}.zip"        
  tags         = merge(var.tags,{ Function = each.key }
}

resource "aws_lambda_function" "lambda_functions" {
  for_each     = local.functions 
  function_name    = each.key
  role             = var.role_arn
  handler          = var.handlers[each.value]
  runtime          = var.runtimes[each.value]
  timeout          = var.timeout[each.value]
  memory_size      = var.memory_size[each.value]
  s3_bucket        = var.bucket_name 
  s3_key           = aws_s3_object.lambda_artifact[each.key].key  
  tags             = merge(var.tags, {"FunctionName" = each.key})
  environment {
    variables      = var.environment_variables[each.value] 
  }
}












