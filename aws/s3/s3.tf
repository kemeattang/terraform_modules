resource "aws_s3_bucket" "this" {
  bucket = local.name

  tags = local.tags
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.bucket_policy != null ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this[count.index].json
}


resource "aws_s3_bucket" "logs" {
  count  = var.enable_logging ? 1 : 0
  bucket = "${local.name}-logs"

  tags = local.tags
}

resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.s3_website ? 1 : 0
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = var.index
  }

  error_document {
    key = var.error
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "logs" {
  count  = var.enable_logging ? 1 : 0
  bucket = aws_s3_bucket.logs[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  rule {
    bucket_key_enabled = var.bucket_key_enabled
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  count  = var.enable_logging ? 1 : 0
  bucket = aws_s3_bucket.logs[0].id

  rule {
    bucket_key_enabled = var.bucket_key_enabled
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [
    aws_s3_bucket_public_access_block.this,
    aws_s3_bucket_ownership_controls.this,
  ]
  bucket = aws_s3_bucket.this.id

  acl = var.acl
}

resource "aws_s3_bucket_acl" "logs" {
  depends_on = [
    aws_s3_bucket_ownership_controls.logs,
  ]
  count  = var.enable_logging ? 1 : 0
  bucket = aws_s3_bucket.logs[0].id

  acl = "log-delivery-write"
}

resource "aws_s3_bucket_logging" "this" {
  count  = var.enable_logging ? 1 : 0
  bucket = aws_s3_bucket.this.id

  target_bucket = aws_s3_bucket.logs[0].id
  target_prefix = "log/"
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = length(keys(var.lifecycle_rules)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules

    content {
      id     = rule.key
      filter {
        prefix = rule.value["prefix"]
      }
      status = rule.value["enabled"] ? "Enabled" : "Disabled"

      abort_incomplete_multipart_upload {
        days_after_initiation =  rule.value["abort_incomplete_multipart_upload_days"]
      }

      dynamic "transition" {
        for_each = rule.value["transition_inputs"] == null ? [] : rule.value["transition_inputs"]

        content {
          date          = transition.value["date"]
          days          = transition.value["days"]
          storage_class = transition.value["storage_class"]
        }
      }

      dynamic "expiration" {
        for_each = rule.value["expiration_inputs"] == null ? [] : rule.value["expiration_inputs"]

        content {
          date                         = expiration.value["date"]
          days                         = expiration.value["days"]
          expired_object_delete_marker = expiration.value["expired_object_delete_marker"]
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = rule.value["noncurrent_version_transition_inputs"] == null ? [] : rule.value["noncurrent_version_transition_inputs"]

        content {
          noncurrent_days = noncurrent_version_transition.value["days"]
          storage_class   = noncurrent_version_transition.value["storage_class"]
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = rule.value["noncurrent_version_expiration_inputs"] == null ? [] : rule.value["noncurrent_version_expiration_inputs"]

        content {
          noncurrent_days = noncurrent_version_expiration.value["days"]
        }
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.acl == "private"      ? true : false
  block_public_policy     = var.bucket_policy == null ? true : false
  ignore_public_acls      = var.acl == "private"      ? true : false
  restrict_public_buckets = var.acl == "public-read"  ? false : true
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_ownership_controls" "logs" {
  count  = var.enable_logging ? 1 : 0
  bucket = aws_s3_bucket.logs[0].id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
