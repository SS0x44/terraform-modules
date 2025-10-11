module "lambda_zip_archives" {
  source         = "./modules/archive_zip"
  function_names = var.function_names
  count          = var.use_as_artifact_bucket ? 0 : 1
}

resource "aws_lambda_function" "lambda_functions" {
  depends_on = [aws_iam_role_policy.lambda_s3_access]

  for_each = { for i, name in var.function_names : name => i }

  function_name    = each.key
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handlers[each.value]
  runtime          = var.runtimes[each.value]
  timeout          = var.timeout[each.value]
  memory_size      = var.memory_size[each.value]
  filename         = var.use_as_artifact_bucket ? null : module.lambda_zip_archives[0].lambda_zip_archive[each.value].output_path
  source_code_hash = var.use_as_artifact_bucket ? null : module.lambda_zip_archives[0].lambda_zip_archive[each.value].output_base64sha256
  s3_bucket        = var.use_as_artifact_bucket ? var.bucket_name : null
  s3_key           = var.use_as_artifact_bucket ? var.s3_keys[each.key] : null
  tags             = merge(var.tags, {"FunctionName" = each.key})
  environment {
    variables      = var.environment_variables[each.value]
  }
}
