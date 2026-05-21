module "s3" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/s3?ref=v1.0.0"
  name   = "${var.name}-${random_string.this.result}"
  tags   = local.tags
}

resource "aws_s3_bucket_object" "home_dir" {
  for_each = local.iteratable_users
  bucket   = module.s3.id
  key      = "${each.key}/"
  source   = "/dev/null"
  tags     = local.tags
}

resource "aws_s3_bucket_object" "superuser_objects" {
  for_each = var.enable_superusers ? toset(var.superusers) : toset([])
  bucket = module.s3.id  # The S3 bucket ID from your existing S3 module
  key    = "${each.key}/" 
  source   = "/dev/null"
  tags     = local.tags
}
