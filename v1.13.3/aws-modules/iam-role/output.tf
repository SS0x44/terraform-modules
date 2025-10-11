output "iam_role_names" {
  value = { for name in var.iam_role_names : name => aws_iam_role.roles[name].name }
}

output "iam_role_arns" {
  value = { for name in var.iam_role_names : name => aws_iam_role.roles[name].arn }
}
