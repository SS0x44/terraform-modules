locals { cloudwatch_alarm = { for alarm in var.cloudwatch_alarms : alarm.name => alarm }}


resource "aws_cloudwatch_metric_alarm" "dynamic_alarms" {
  for_each = local.cloudwatch_alarm

  alarm_name                = each.value.name
  namespace                 = each.value.namespaces
  metric_name               = each.value.metric_names
  statistic                 = each.value.statistics
  period                    = each.value.periods
  evaluation_periods        = each.value.evaluation_periods
  threshold                 = each.value.thresholds
  comparison_operator       = each.value.comparison_operators
  dimensions                = each.value.dimensions
  alarm_description         = each.value.alarm_description
  alarm_actions             = [var.sns_topic_arns]
  tags                      = var.tags
}
