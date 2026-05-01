resource "datadog_synthetics_test" "this" {
  type    = var.type
  subtype = var.subtype

  request_definition {
    method = var.method
    url    = var.url
  }

  request_headers = var.request_headers

  dynamic "assertion" {
    for_each = var.assertions
    content {
      type     = assertion.value["type"]
      operator = assertion.value["operator"]
      target   = assertion.value["target"]
    }
  }

  locations = var.locations

  dynamic "options_list" {
    for_each = var.options_list
    content {
      tick_every       = options_list.value["tick_every"]
      follow_redirects = options_list.value["follow_redirects"]
      retry {
        count    = options_list.value["retry"]["count"]
        interval = options_list.value["retry"]["interval"]
      }

      monitor_options {
        renotify_interval = options_list.value["monitor_options"]["renotify_interval"]
      }
    }
  }

  name    = local.name
  message = local.message
  tags    = local.tags

  status = "live"
}

