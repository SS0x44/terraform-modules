resource "aws_lambda_function" "lambda_functions" {
  depends_on = [aws_iam_role_policy.lambda_s3_access]
  for_each = { for i, name in var.function_names : name => i }
  
  function_name    = each.key
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handlers[each.value]
  runtime          = var.runtimes[each.value]
  filename         = data.archive_file.lambda_zip_archive[each.value].output_path
  source_code_hash = data.archive_file.lambda_zip_archive[each.value].output_base64sha256
  timeout          = var.timeout[each.value]
  memory_size      = var.memory_size[each.value]
  tags             = var.tags

  environment {
    variables = var.environment_variables_list[each.value]
  }
  lifecycle {
    ignore_changes = [source_code_hash]
  }
}

