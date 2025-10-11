resource "aws_iam_role" "roles" {
  for_each = { for name in var.iam_role_names : name => name }
  name = each.key
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = var.effect[each.key]
      Principal = {
        Service = var.services[each.key]
      }
      Action = var.actions[each.key]
    }]
  })
  tags = var.tags
}
