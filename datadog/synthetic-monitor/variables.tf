variable "assertions" {
  type = list(object({
    type   = string
    operator = string
    target = string
  }))
  default = [
    {
      type     = "statusCode"
      operator = "is"
      target   = "200"
    },
  ]
  description = "Assertions used for the test"
}


variable "locations" {
  type = list(string)
  default = [
    "aws:us-east-2",
  ]
  description = "List of locations used to run the test."
}

variable "method" {
  type        = string
  default     = "GET"
  description = "Type of method used"
}

variable "name" {
  type        = string
  default     = null
  description = "Name of Datadog synthetics test."
}

variable "notification_list" {
  type        = list(string)
  default     = []
  description = "Channels to get notified"
}

variable "options_list" {
  type = list(object(
    {
      tick_every       = number
      follow_redirects = bool
      retry = object({
        count    = number
        interval = number
      })
      monitor_options = object({
        renotify_interval = number
      })
    }
  ))
  default = [
    {
      tick_every       = 60
      follow_redirects = true

      retry = {
        count    = 1
        interval = 30
      }

      monitor_options = {
        renotify_interval = 720
      }
    }
  ]
  description = "Options used for the test"
}

variable "request_headers" {
  type = map(string)
  default = {
    "Content-Type" = "application/json",
  }
  description = "Header name and value map."
}

variable "subtype" {
  type        = string
  default     = "http"
  description = "The subtype of the Synthetic API test."
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "A list of tags to associate with your synthetics test."
}

variable "type" {
  type        = string
  default     = "api"
  description = "Synthetics test type."
}

variable "url" {
  type        = string
  default     = "https://supremeecom.com"
  description = "URl used for the test"
}
