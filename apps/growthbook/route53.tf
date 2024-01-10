data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "growthbook" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.host_name}.${var.domain}"
  type    = "CNAME"
  ttl     = "300"
  records = [module.alb.this_lb_dns_name]
}