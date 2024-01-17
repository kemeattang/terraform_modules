locals {
  domain = length(var.sub_domain) > 0 ? "${var.sub_domain}.${var.domain}" : var.domain

  domain_validation_option = tolist(
    var.target_region == "global" ? aws_acm_certificate.this[0].domain_validation_options : aws_acm_certificate.local[0].domain_validation_options
  )[0]

  tags = merge(
    var.tags,
    {
      module = "aws-acm"
    }
  )
}