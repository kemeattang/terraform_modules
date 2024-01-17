
resource "aws_acm_certificate" "this" {
  count             = var.target_region == "global" ? 1 : 0
  domain_name       = local.domain
  validation_method = var.validation_method

  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "local" {
  count             = var.target_region != "global" ? 1 : 0
  domain_name       = local.domain
  validation_method = var.validation_method

  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  count                   = var.enable_validation && var.target_region == "global" ? 1 : 0
  certificate_arn         = aws_acm_certificate.this[count.index].arn
  validation_record_fqdns = tolist(module.dns.fqdn)
}

resource "aws_acm_certificate_validation" "local" {
  count                   = var.enable_validation && var.target_region != "global" ? 1 : 0
  certificate_arn         = aws_acm_certificate.local[count.index].arn
  validation_record_fqdns = tolist(module.dns.fqdn)
}