resource "aws_lambda_function" "lambda_functions" {
  depends_on       = [aws_iam_role_policy.lambda_s3_access]
  for_each         = { for name in var.function_names : name => name }
  function_name    = each.key
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handlers[each.key]
  runtime          = var.runtimes[each.key]
  filename         = data.archive_file.lambda_zip_archive[each.key].output_path
  source_code_hash = data.archive_file.lambda_zip_archive[each.key].output_base64sha256
  timeout          = var.timeout[each.key]
  memory_size      = var.memory_size[each.key]
  tags             = var.tags
  environment {
    variables = var.environment_variables_map[each.key]
  }
  lifecycle {
    ignore_changes = [source_code_hash]
  }
}
