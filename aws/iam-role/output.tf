output "arn" {
  value = aws_iam_role.this.arn
}

output "instance_profile" {
  value = var.create_instance_profile ? aws_iam_instance_profile.this[0].name : null
}

output "name" {
  value = local.name
}
