output "name_servers" {
  value       = var.create_hosted_zone ? aws_route53_zone.this[0].name_servers : []
  description = "Route53 DNS Zone Name Servers"
}

output "zone_id" {
  value       = local.zone_id
  description = "Route53 DNS Zone ID"
}

output "fqdn" {
  value       = values(aws_route53_record.this)[*].fqdn
  description = "Fully-qualified domain name value"
}
