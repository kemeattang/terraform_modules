data "aws_route53_zone" "this" {
  count = local.zone_id_lookup_bool ? 1 : 0
  name  = var.domain
}