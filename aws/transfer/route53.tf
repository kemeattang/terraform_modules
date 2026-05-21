module "route53" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/dns?ref=v0.1.0"
  domain = var.domain

  records = {
    "${var.sub_domain}" = {
      type = "CNAME"
      ttl  = 300
      records = [
        aws_transfer_server.this.endpoint
      ]
    }
  }

  create_hosted_zone = false

  tags = local.tags
}
