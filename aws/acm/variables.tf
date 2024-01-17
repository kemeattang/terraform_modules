variable "domain" {
  type        = string
  default     = ""
  description = "The name of domain to use."
}

variable "enable_validation" {
  type        = bool
  default     = true
  description = "Set to prevent validation of  DNS and EMAIL."
}

variable "sub_domain" {
  type        = string
  default     = ""
  description = "The name of sub domain to use."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the ACM."
}

variable "target_region" {
  type        = string
  default     = "global"
  description = "The region to create the certificate in."
}

variable "validation_method" {
  type        = string
  default     = "DNS"
  description = "For validation, DNS or EMAIL."
}
