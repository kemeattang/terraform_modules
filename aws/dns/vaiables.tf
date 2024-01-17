variable "create_hosted_zone" {
  type        = bool
  default     = true
  description = "boolean used to determin if a hosted zone should be created."
}

variable "domain" {
  type        = string
  description = "The domain name to use for the hosted zone."
}

variable "records" {
  type = map(object({
    type    = string
    ttl     = number
    records = list(string)
  }))
  default     = {}
  description = "A map of record types to a list of records. The key will be used for the record name, while the value object will be used for ttl, type, and record values.  This is not recommended to be used in tandem with `var.records`."
}

variable "record" {
  type = object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  })
  default     = null
  description = "A record to create as a part of an upstream terraform module.  This can oly create one record. This is not recommended to be used in tandem with `var.records`."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the resource"
}

variable "zone_id" {
  type        = string
  default     = null
  description = "The zone id to use for the record"
}

variable "alias" {
  type        = bool
  default     = false
  description = "boolean used to determin if a hosted zone should be created."
}

variable "aliasrecord" {
  type = object({
    name    = string
    type    = string
  })
  default     = null
  description = "A record to create as a part of an upstream terraform module.  This can oly create one record for alias. This is not recommended to be used in tandem with `var.records`."
}

variable "target_dns_name" {
  type        = string
  description = "DNS name of target resource (e.g. ALB, ELB)"
}

variable "target_zone_id" {
  type        = string
  description = "ID of target resource (e.g. ALB, ELB)"
}

variable "evaluate_target_health" {
  type        = bool
  default     = false
  description = "Set to true if you want Route 53 to determine whether to respond to DNS queries"
}