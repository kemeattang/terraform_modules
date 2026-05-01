output "arn" {
  value       = aws_s3_bucket.this.arn
  description = "S3 Bucket ARN."
}

output "id" {
  value       = aws_s3_bucket.this.id
  description = "The id of s3 bucket."
}

output "s3_get_policy_json" {
  value       = element(concat(data.aws_iam_policy_document.this.*.json, [""]), 0)
  description = "S3 get policy json."
}