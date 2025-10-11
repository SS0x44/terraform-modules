resource "aws_iam_role" "roles" {
  for_each = { for i, name in var.iam_role_names : name => i }

  name               = each.key
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = var.permission_effect
      Principal = {
        Service = var.service_pricipal
      }
      Action = "sts:AssumeRole"
    }]
  })
  tags = var.tags
}

resource "aws_iam_role_policy" "iam_inline_policies" {
  for_each = { for i, name in var.iam_role_names : name => i }

  name   = "${each.key}-inline-policy"
  role   = aws_iam_role.roles[each.key].name
  policy = jsonencode({
  Version = "2012-10-17"
  Statement = [{
    Effect   = var.permission_effect
    Action   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    Resource = "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${module.lambda.lambda_function_names[each.key]}:*"
  }]
})

}


