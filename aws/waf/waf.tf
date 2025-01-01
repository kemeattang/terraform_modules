resource "aws_wafv2_rule_group" "this" {
  name        = var.rule_group_name
  description = "A rule group for protecting cloud-native applications"
  scope       = var.scope

  visibility_config {
    cloudwatch_metrics_enabled = true
    sampled_requests_enabled   = true
    metric_name                = var.rule_group_metric_name
  }

  rules {
    name     = "sql-injection-rule"
    priority = 1
    action {
      block {}
    }

    statement {
      sqli_match_statement {
        field_to_match {
          body {}
        }
        text_transformations {
          type = "NONE"
        }
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "SQLInjectionRule"
    }
  }

  rules {
    name     = "xss-rule"
    priority = 2
    action {
      block {}
    }

    statement {
      xss_match_statement {
        field_to_match {
          body {}
        }
        text_transformations {
          type = "NONE"
        }
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "XSSRule"
    }
  }
}

resource "aws_wafv2_web_acl" "this" {
  name        = local.name
  description = var.web_acl_description
  scope       = var.scope

  default_action {
    allow {}
  }

  rule_group_reference_statement {
    arn = aws_wafv2_rule_group.this.arn
  }

  rules {
    name     = "rate-limit-rule"
    priority = var.rate_limit_priority
    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = var.rate_limit
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      sampled_requests_enabled   = true
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitRule"
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    sampled_requests_enabled   = true
    metric_name                = "WebACL"
  }
}

resource "aws_wafv2_ip_set" "this" {
  name        = var.ip_set_name
  description = "Set of IPs for rate limiting"
  scope       = var.scope

  addresses = var.ip_addresses
}

resource "aws_wafv2_web_acl_association" "this" {
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.this.arn
}

resource "aws_wafv2_logging_configuration" "this" {
  log_destination {
    cloudwatch_logs {
      log_group_name = var.log_group_name
    }
  }
  resource_arn = aws_wafv2_web_acl.this.arn
  is_enabled   = true
}
