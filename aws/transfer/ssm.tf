resource "aws_ssm_parameter" "private_key" {
  for_each = local.iteratable_users
  name     = "/${var.name}/${each.key}/private_key"
  type     = "SecureString"
  value    = each.value["public_key"] == null ? tls_private_key.this[each.key].private_key_pem : "Key N/A because public key provided by customer."
}

resource "aws_ssm_parameter" "public_key" {
  for_each = local.iteratable_users
  name     = "/${var.name}/${each.key}/public_key"
  type     = "String"
  value    = each.value["public_key"] == null ? tls_private_key.this[each.key].public_key_openssh : each.value["public_key"]
}
