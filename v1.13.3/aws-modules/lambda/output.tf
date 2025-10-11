output "lambda_functions" {
  value = {
    for name, fn in aws_lambda_function.lambda_functions :
    name => {
      function_name = fn.function_name
    }
  }
}

output "s3_keys" {
  value = [
    for i in range(length(var.function_names)) :
    aws_s3_object.lambda_artifact[i].key
  ]
}
