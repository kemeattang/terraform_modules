locals {
  name        = var.name == null ? random_uuid.name.result : var.name
  ip_set_name = var.ip_set_name == null ? random_uuid.name.result : var.ip_set_name
  metric_name = replace(local.name, "-", "")
  tags = merge(
    var.tags,
    {
      module = "waf"
    }
  )
}