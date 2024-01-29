locals {
  name = var.name == null ? random_uuid.this.result : var.name
  tags = merge(
    var.tags,
    {
      module = "aws-backup"
    }
  )
}