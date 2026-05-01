module "dns" {
  source             = "git@github.com:kemeattang/terraform_modules.git//aws/dns?ref=v1.0.0"
  create_hosted_zone = false
  domain             = var.domain

  record = {
    name = replace(local.domain_validation_option["resource_record_name"], ".${var.domain}.", "")
    type = local.domain_validation_option["resource_record_type"]
    ttl  = 300
    records = [
      local.domain_validation_option["resource_record_value"]
    ]
  }

  tags = local.tags
}