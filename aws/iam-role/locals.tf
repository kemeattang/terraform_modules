locals {
  name = var.name == null ? random_uuid.name.result : var.name
  tags = merge(
    var.tags,
    {
      module = "aws-iam-role"
    }
  )
}