module "s3" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/s3?ref=v1.1.0"

  name = local.bucket_name
  tags = local.tags
}

resource "aws_s3_bucket_object" "requirements" {
  count = var.requirements != null ? 1 : 0

  bucket = module.s3.id
  key    = "requirements-${md5(var.requirements)}.txt"
  content = var.requirements

  etag = md5(var.requirements)
}
