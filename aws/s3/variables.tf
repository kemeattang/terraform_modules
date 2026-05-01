variable "acl" {
  type        = string
  default     = "private"
  description = "ACL for S3 bucket"
}

variable "bucket_key_enabled" {
  type        = bool
  default     = true
  description = "Whether or not to use Amazon S3 Bucket Keys for SSE-KMS."
}

variable "bucket_policy" {
  type = map(object({
    effect = string
    principals = list(object({
      type        = string
      identifiers = list(string)
    }))
    actions   = list(string)
    resources = list(string)
  }))
  default     = null
  description = "S3 Bucket policy."
}

variable "enable_logging" {
  type        = bool
  default     = true
  description = "Enable logging for S3 bucket"
}

variable "error" {
  type        = string
  default     = "error.html"
  description = "The default error html file, An absolute path to the document to return in case of a error"
}

variable "index" {
  type        = string
  default     = "index.html"
  description = "Default index document to host static website"
}

variable "lifecycle_rules" {
  type = map(object({
    id                                     = string
    prefix                                 = string
    enabled                                = bool
    abort_incomplete_multipart_upload_days = string
    expiration_inputs = list(object({
      date                         = string
      days                         = number
      expired_object_delete_marker = string
    }))
    transition_inputs = list(object({
      date          = string
      days          = number
      storage_class = string
    }))
    noncurrent_version_transition_inputs = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_expiration_inputs = list(object({
      days = number
    }))
  }))
  default     = {}
  description = "A map of lifecycle rules. WARNING: Check https://aws.amazon.com/s3/pricing/ for lifecycle transition pricing before adding a lifecycle."
}

variable "name" {
  type        = string
  default     = null
  description = "The name of the s3 bucket"
}

variable "s3_website" {
  type        = bool
  default     = false
  description = "Whether or not to use Amazon S3 Bucket Website"
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags of the s3 bucket"
}

variable "versioning" {
  type        = bool
  default     = true
  description = "Enable versioning for S3 bucket"
}
