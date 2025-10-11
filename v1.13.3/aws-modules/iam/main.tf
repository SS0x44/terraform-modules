resource "aws_iam_role" "roles" {
  for_each = { for i, name in var.iam_role_names : name => i }

  name               = each.key
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = var.permission_effect
      Principal = {
        Service = var.service_principal
      }
      Action = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}
