resource "aws_cloudwatch_metric_alarm" "this" {
  for_each = var.metrics

  alarm_name        = each.key
  alarm_description = var.alarm_description

  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods

  unit = var.unit

  metric_name = each.value["metric_name"]
  dimensions  = each.value["dimensions"]
  namespace   = each.value["namespace"]
  threshold   = each.value["threshold"]

  period    = var.period
  statistic = var.statistic

  alarm_actions = local.alarm_actions
  ok_actions    = local.ok_actions

  tags = var.tags
}
