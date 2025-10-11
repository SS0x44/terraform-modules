output "kms_key_arns" {
  value = { for key_name in var.kms_keys : key_name => aws_kms_key.kms_key[key_name].arn }
}
