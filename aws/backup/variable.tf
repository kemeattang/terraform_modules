variable "name" {
  type        = string
  default     = null
  description = "The name of the server"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to the resource"
}

variable "schedule" {
  type        = string
  default     = "cron(0 12 * * ? *)"
  description = "Schedule for backup"
}

variable "delete_after" {
  type        = number
  default     = 30
  description = "How long to store the backup"
}

variable "resources" {
  type        = list(string)
  default     = null
  description = "An array of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan."
}

variable "selection_tags" {
  type = object({
    type  = string
    key   = string
    value = string
  })
  default = {
    type  = "STRINGEQUALS"
    key   = "aws_backup"
    value = "true"
  }
  description = "A mapping of key-value pairs that is used to identify resources that are associated with this rule."
}
