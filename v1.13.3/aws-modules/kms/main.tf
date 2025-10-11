data "aws_caller_identity" "current" {}

locals {
  kms_key_role = zipmap(var.kms_keys, var.kms_roles)
}

resource "aws_kms_key" "kms_key" {
  for_each = local.kms_key_role
  description             = "${each.key} encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = var.in_days
  tags                    = var.tags
}

resource "aws_kms_key_policy" "kms_key_policy" {
  for_each = local.kms_key_role_map
  key_id = aws_kms_key.kms_key[each.key].id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-policy-${each.key}"
    Statement = [
      {
        Sid      = "AllowSpecificRoleOnly"
        Effect   = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${each.value}"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}
