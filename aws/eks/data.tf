data "aws_availability_zones" "this" {}

data "aws_partition" "current" {}

data "aws_iam_roles" "admin_roles" {
  name_regex = var.admin_role_pattern
}
