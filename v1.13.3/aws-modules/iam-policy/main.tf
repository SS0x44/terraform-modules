resource "aws_iam_role_policy" "iam_inline_policy" {
  for_each = { for i, name in var.iam_role_names : name => i }

  name = "${each.key}-inline-policy"
  role = aws_iam_role.roles[each.key].name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = var.sid
        Effect = var.permission
        Action = var.actions
        Resource = var.resources
      }
      ]})
}



