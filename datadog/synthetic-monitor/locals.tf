locals {
  message = <<-MESSAGE
  The following endpoint appears to be down:
  ${var.url}

  Notify:
  ${local.notification_list}
  MESSAGE

  name              = var.name == null ? random_uuid.name.result : var.name
  notification_list = join(", ", var.notification_list)
  tags = concat(
    var.tags,
    [
      "url:${var.url}",
      "name:${local.name}",
    ]
  )
}
