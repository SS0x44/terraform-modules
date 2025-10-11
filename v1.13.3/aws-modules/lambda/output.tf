output "lambda_functions" {
  value = {
    for name, fn in aws_lambda_function.lambda_functions :
    name => {
      function_name = fn.function_name
    }
  }
}
