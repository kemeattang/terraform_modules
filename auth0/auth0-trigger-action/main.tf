resource "auth0_trigger_actions" "this" {
  trigger = var.trigger

  dynamic "actions" {
    for_each = var.actions != null ? var.actions : []
    content {
      id           = actions.value.id
      display_name = actions.value.display_name
    }
  }
}
