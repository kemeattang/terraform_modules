# Create a bucket for LB logging:

```
module "s3" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/s3?ref=s3-v0.1.0"

  name = "lb-logs-${local.name}"

  bucket_policy = {
    elb_logs = {
      effect = "Allow"

      principals = [
          {
              identifiers = ["arn:aws:iam::797873946194:root"] # elb account
              type = "AWS"
          }
      ]

      actions   = ["s3:PutObject"]
      resources = ["${module.s3.arn}/*"]
    }
  }

  tags = local.tags
}
```

# Create a S3 website

```
module "s3" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/s3?ref=v1.1.0"

  name = "${var.sub_domain}.${var.domain}"

  acl    = "public-read"
  index  = "index.html"
  error  = "error.html"

  tags = local.tags
}
```

# Create a bucket with a lifecycle

```
module "s3" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/s3?ref=v1.1.0"
  name   = var.name
  lifecycle_rules = {
    Example_delete_files_older_than_30_days = {
      id                                     = "delete-files"
      enabled                                = true
      prefix                                 = ""
      abort_incomplete_multipart_upload_days = null
      expiration_inputs = [
        {
          days                         = 30
          date                         = null
          expired_object_delete_marker = null
        },
      ]
      transition_inputs                    = []
      noncurrent_version_transition_inputs = []
      noncurrent_version_expiration_inputs = []
    }
  }
  tags = local.tags
}
```

# Create a bucket without logging or versioning

```
module "s3" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/s3?ref=s3-v0.1.0"

  enable_logging = false
  versioning     = false

  tags = local.tags
}
```
