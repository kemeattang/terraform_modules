resource "aws_route53_zone" "this" {
  count = var.create_hosted_zone ? 1 : 0
  name  = var.domain
  tags  = var.tags
}
 
resource "aws_route53_record" "this" {
  for_each = var.records
  zone_id  = local.zone_id
  name     = "${each.key}.${var.domain}"
  type     = each.value["type"]
  ttl      = each.value["ttl"]
  records  = each.value["records"]
}

resource "aws_route53_record" "single" {
  count   = var.record != null ? 1 : 0
  zone_id = local.zone_id
  name    = "${var.record["name"]}.${var.domain}"
  type    = var.record["type"]
  ttl     = var.record["ttl"]
  records = var.record["records"]
}

resource "aws_route53_record" "alias" {
  count   = var.alias ? 1 : 0
  zone_id = local.zone_id
  name    = "${var.aliasrecord["name"]}.${var.domain}"
  type    = var.aliasrecord["type"]
  alias {
    name                   = var.target_dns_name
    zone_id                = var.target_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}