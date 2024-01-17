output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = element(concat(aws_acm_certificate_validation.this.*.certificate_arn, aws_acm_certificate.this.*.arn, [""]), 0)
}

output "domain_name" {
  value       = aws_acm_certificate.this[0].domain_name  
  description = "The name of the domain"
}
