resource "aws_transfer_ssh_key" "this" {
  for_each  = local.iteratable_users
  server_id = aws_transfer_server.this.id
  user_name = aws_transfer_user.this[each.key].user_name
  body      = each.value["public_key"] == null ? tls_private_key.this[each.key].public_key_openssh : each.value["public_key"]
}

resource "aws_transfer_server" "this" {
  identity_provider_type = "SERVICE_MANAGED"
  logging_role           = module.transfer_logging.arn

  tags = local.tags
}

resource "aws_transfer_user" "this" {
  for_each = local.iteratable_users

  server_id = aws_transfer_server.this.id
  user_name = each.key

  home_directory_type = "LOGICAL"

  home_directory_mappings {
    entry  = "/"
    target = "/${module.s3.id}/${each.key}"
  }

  role = module.iam[each.key].arn
  tags = local.tags
}

#super user created for AWS Transfer
resource "aws_transfer_user" "superuser" {
  for_each = var.enable_superusers ? toset(var.superusers) : toset([])

  server_id = aws_transfer_server.this.id
  user_name = each.key
  # No home_directory_mappings, so user will have full access to all folders
  # Reference the role created by the superusers_iam module
  role = module.superusers_iam[each.key].arn

  tags = local.tags
}
# AWS Transfer for SSH key
resource "aws_transfer_ssh_key" "superuser_this" {
  for_each = var.enable_superusers ? toset(var.superusers) : toset([])
  server_id = aws_transfer_server.this.id
  user_name = aws_transfer_user.this[each.key].user_name
  body      = each.value["public_key"] == null ? tls_private_key.superuser[each.key].public_key_openssh : each.value["public_key"]
}