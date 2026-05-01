data "aws_sns_topic" "this" {
  count = var.sns_topic_name != null ? 1 : 0
  name  = var.sns_topic_name
}
