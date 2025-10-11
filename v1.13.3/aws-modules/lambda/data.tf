data "archive_file" "lambda_zip_archive" {
  for_each    = { for i, name in var.function_names : i => name }
  type        = "zip"
  source_dir  = "${path.module}/src/${each.value}"
  output_path = "${path.module}/build/${each.value}.zip"
}
