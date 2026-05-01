data "aws_iam_policy_document" "this" {
  count = var.bucket_policy != null ? 1 : 0

  dynamic "statement" {
    for_each = var.bucket_policy
    content {
      sid    = statement.key
      effect = statement.value["effect"]

      dynamic "principals" {
        for_each = statement.value["principals"]
        content {
          type        = principals.value["type"]
          identifiers = principals.value["identifiers"]
        }
      }

      actions   = statement.value["actions"]
      resources = statement.value["resources"]
    }
  }
}