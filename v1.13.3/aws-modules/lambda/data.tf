data "archive_file" "lambda_zip_archive" {
  type        = "zip"
  source_dir  = var.src_dir   
  output_path = var.output_path
}
