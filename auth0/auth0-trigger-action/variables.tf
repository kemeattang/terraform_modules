variable "trigger" {
  description = "The ID of the trigger to bind with."
  type        = string
}

variable "actions" {
  description = "List of third party npm modules, and their versions, that this action depends on."
  type = list(object({
    id           = string
    display_name = string
  }))
  default = []
}
