data "archive_file" "zip_archive_files" {
  for_each    = { for i, name in var.function_names : i => name }
  type        = "zip"
  source_dir  = "${path.module}/src/${each.value}"
  output_path = "${path.module}/artifact/${each.value}.zip"
}

