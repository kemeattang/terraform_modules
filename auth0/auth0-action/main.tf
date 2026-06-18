resource "auth0_action" "this" {
  name    = var.name
  runtime = var.runtime
  deploy  = var.deploy
  code    = var.code

  supported_triggers {
    id      = var.supported_triggers.id
    version = var.supported_triggers.version
  }

  dynamic "dependencies" {
    for_each = var.dependencies != null ? var.dependencies : []
    content {
      name    = dependencies.value.name
      version = dependencies.value.version
    }
  }

  dynamic "secrets" {
    for_each = var.secrets != null ? var.secrets : []
    content {
      name  = secrets.value.name
      value = secrets.value.value
    }
  }
}
