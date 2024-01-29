variable "assume_role_policy" {
  type        = string
  description = "Policy that grants an entity permission to assume the role"

  default = <<-ASSUME_ROLE_POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  ASSUME_ROLE_POLICY
}

variable "create_instance_profile" {
  type        = bool
  default     = true
  description = "Boolean to create an instance profile for the role"
}

variable "managed_policy_arns" {
  type        = list(string)
  default     = []
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role."
}

variable "max_session_duration" {
  description = "Maximum session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "name" {
  type        = string
  default     = null
  description = "Friendly name of the role."
}

variable "path" {
  type        = string
  default     = null
  description = "Path to the role."
}

variable "policies" {
  type        = list(string)
  default     = []
  description = "Policy document as a JSON formatted string."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Key-value mapping of tags for the IAM role"
}