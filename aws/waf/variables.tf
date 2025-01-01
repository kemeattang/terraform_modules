variable "name" {
  type        = string
  default     = null
  description = "A name of the for the webacl group."
}

variable "web_acl_name" {
  description = "The name of the WAF WebACL"
  type        = string
  default     = "example-web-acl"
}

variable "web_acl_description" {
  description = "Description for the WAF WebACL"
  type        = string
  default     = "WebACL for securing cloud-native application"
}

variable "scope" {
  description = "Scope of the WebACL. Use 'REGIONAL' for ALB, 'CLOUDFRONT' for CloudFront"
  type        = string
  default     = "REGIONAL"
}

variable "rule_group_name" {
  description = "The name of the rule group"
  type        = string
  default     = "example-rule-group"
}

variable "rule_group_metric_name" {
  description = "The metric name for the rule group"
  type        = string
  default     = "ExampleRuleGroup"
}

variable "rate_limit" {
  description = "The rate limit for DDoS mitigation"
  type        = number
  default     = 1000
}

variable "rate_limit_priority" {
  description = "Priority for the rate limit rule"
  type        = number
  default     = 1
}

variable "ip_set_name" {
  description = "The name of the IP Set for rate limiting"
  type        = string
  default     = null
}

variable "ip_addresses" {
  description = "List of IP addresses to apply rate limiting"
  type        = list(string)
  default     = []
}

variable "resource_arn" {
  description = "The ARN of the resource to associate with the WAF WebACL (e.g., ALB or API Gateway)"
  type        = string
}

variable "log_group_name" {
  description = "CloudWatch log group name for WAF logs"
  type        = string
  default     = "/aws/wafv2/logs"
}
