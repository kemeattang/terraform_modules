locals {
  alarm_actions = length(var.actions["alarm_actions"]) > 0 ? var.actions["alarm_actions"] : data.aws_sns_topic.this[*].arn
  ok_actions    = length(var.actions["ok_actions"]) > 0 ? var.actions["ok_actions"] : data.aws_sns_topic.this[*].arn

  tags = merge(
    var.tags,
    {
      module = "aws-cloudwatch"
    }
  )
}
