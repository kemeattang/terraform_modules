resource "tls_private_key" "this" {
  for_each  = {
    for user in local.iteratable_users: user.username => user if user.public_key == null
  }
  algorithm = "RSA"
  rsa_bits  = 4096
}

#tls for super user if enabled

resource "tls_private_key" "superuser" {
  for_each = var.enable_superusers ? toset(var.superusers) : toset([])
  algorithm = "RSA"
  rsa_bits  = 4096
}
