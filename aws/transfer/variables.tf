variable "domain" {
  type        = string
  default     = "termnl.cloud"
  description = "The domain of the server"
}

variable "sub_domain" {
  type        = string
  default     = "sftp"
  description = "The sub domain of the server"
}

variable "name" {
  type        = string
  default     = "tc-sftp"
  description = "The name of the server"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to the resource"
}

variable "users" {
  type        = list(object({
    username   = string
    public_key = optional(string, null)
  }))
  default     = []
  description = "List of SFTP users"
}

variable "enable_superusers" {
  description = "Boolean flag to enable or disable the creation of superusers"
  type        = bool
  default     = false
}

variable "superusers" {
  description = "List of superusers"
  type        = list(string)  # Just the names of the superusers
  default     = []
}
