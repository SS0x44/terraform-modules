resource "aws_iam_role_policy" "iam_inline_policy" {
  for_each = var.iam_roles
  name = "${each.key}-inline-policy"
  role = each.key # or use var.iam_role_arns[each.key] if ARN is needed

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = var.sid
        Effect   = var.permission
        Action   = var.actions
        Resource = var.resources
      }
    ]
  })
}



