resource "aws_iam_role_policy" "iam_inline_policy" {
  for_each = { for i, name in var.iam_role_names : name => i }

  name = "${each.key}-inline-policy"
  role = aws_iam_role.roles[each.key].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CloudWatchLogsAccess"
        Effect = var.permission_effect
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${module.lambda.lambda_function_names[each.key]}:*"
      },
      {
        Sid    = "SQSAccess"
        Effect = var.permission_effect
        Action = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = module.sqs.queue_arns[each.key]
      },
      {
        Sid    = "S3Access"
        Effect = var.permission_effect
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = module.s3.bucket_arns[each.key]
      },
      {
        Sid    = "EventBridgeAccess"
        Effect = var.permission_effect
        Action = [
          "events:PutEvents",
          "events:DescribeRule",
          "events:EnableRule"
        ]
        Resource = module.eventbridge.rule_arns[each.key]
      }
    ]
  })
}



