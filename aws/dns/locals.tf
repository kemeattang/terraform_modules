locals {
  zone_id_lookup_bool = var.zone_id == null && !var.create_hosted_zone
  zone_id_lookup      = local.zone_id_lookup_bool ? data.aws_route53_zone.this[0].zone_id : var.zone_id
  zone_id             = var.create_hosted_zone ? aws_route53_zone.this[0].zone_id : local.zone_id_lookup
  tags = merge(
    var.tags,
    {
      module = "aws-dns"
    }
  )
}