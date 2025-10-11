resource "aws_kms_key_policy" "kms_key_policy" {
  for_each = var.kms_keys
  key_id = aws_kms_key.kms_key[each.key].id
}

resource "aws_kms_key_policy" "kms_key_policy" {
  for_each = var.kms_keys
  key_id = aws_kms_key.kms_key[each.key].id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-policy-${each.key}"
    Statement = [
      {
        Sid      = "AllowSpecificRoleOnly"
        Effect   = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.kms_roles[each.key]}"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}
