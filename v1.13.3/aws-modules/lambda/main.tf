resource "aws_lambda_function" "lambda_functions" {
  depends_on       = [aws_iam_role_policy.lambda_s3_access] 
  function_name    = var.function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = data.archive_file.lambda_zip_archive.output_path
  source_code_hash = data.archive_file.lambda_zip_archive.output_base64sha256
  timeout          = var.timeout                     
  memory_size      = var.memory_size                
  publish          = true                            
  package_type     = "Zip"  
  tags             = var.tags    
  environment {
    variables = var.environment_variables            
  }                         
  lifecycle {
    ignore_changes = [source_code_hash]              
  }
}
