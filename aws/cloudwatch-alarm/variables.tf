variable "actions" {
  type = object({
    ok_actions    = list(string)
    alarm_actions = list(string)
  })
  default = {
    ok_actions    = []
    alarm_actions = []
  }
  description = "Alarm actions for Cloudwatch alert."
}

variable "alarm_description" {
  description = "The description for the alarm."
  type        = string
  default     = null
}

variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold."
  type        = number
  default     = 3
}

variable "metrics" {
  description = "The metrics configuration for cloudwatch alarm"
  type = map(
    object({
      namespace   = string
      threshold   = number
      metric_name = string
      dimensions  = map(string)
    })
  )
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied."
  type        = string
  default     = 60
}

variable "statistic" {
  type        = string
  default     = "Average"
  description = "The statistic to apply to the alarm's associated metric."
}

variable "sns_topic_name" {
  type        = string
  default     = "infrastructure"
  description = "The SNS topic name to send the alarm notification."
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "unit" {
  description = "The unit for the alarm's associated metric."
  type        = string
  default     = null
}
