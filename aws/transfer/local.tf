locals {
  iteratable_users = {
    for user in var.users : user.username => user
  }
  tags = merge(
    var.tags,
    {
      module = "aws-transfer"
    }
  )
}
