variable "name" {
  description = "The name of the action."
  type        = string
}

variable "runtime" {
  description = "The Node runtime. Defaults to node12. Possible values are: node12, node16 or node18."
  type        = string
  default     = null
}

variable "code" {
  description = "The source code of the action."
  type        = string
}

variable "deploy" {
  description = "Deploying an action will create a new immutable version of the action. If the action is currently bound to a trigger, then the system will begin executing the newly deployed version of the action immediately."
  type        = bool
  default     = null
}

variable "supported_triggers" {
  description = "List of triggers that this action supports. At this time, an action can only target a single trigger at a time. Read Retrieving the set of triggers available within actions to retrieve the latest trigger versions supported."
  type = object({
    id      = string
    version = string
  })
  default = ({
    id      = "post-login"
    version = "v3"
  })
}

variable "dependencies" {
  description = "List of third party npm modules, and their versions, that this action depends on."
  type = list(object({
    name    = string
    version = string
  }))
  default = []
}

variable "secrets" {
  description = "List of secrets that are included in an action or a version of an action."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
