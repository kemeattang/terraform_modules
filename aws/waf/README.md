<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_ip_set.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |
| [aws_wafv2_logging_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_logging_configuration) | resource |
| [aws_wafv2_rule_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_rule_group) | resource |
| [aws_wafv2_web_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [random_uuid.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ip_addresses"></a> [ip\_addresses](#input\_ip\_addresses) | List of IP addresses to apply rate limiting | `list(string)` | `[]` | no |
| <a name="input_ip_set_name"></a> [ip\_set\_name](#input\_ip\_set\_name) | The name of the IP Set for rate limiting | `string` | `null` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | CloudWatch log group name for WAF logs | `string` | `"/aws/wafv2/logs"` | no |
| <a name="input_name"></a> [name](#input\_name) | A name of the for the webacl group. | `string` | `null` | no |
| <a name="input_rate_limit"></a> [rate\_limit](#input\_rate\_limit) | The rate limit for DDoS mitigation | `number` | `1000` | no |
| <a name="input_rate_limit_priority"></a> [rate\_limit\_priority](#input\_rate\_limit\_priority) | Priority for the rate limit rule | `number` | `1` | no |
| <a name="input_resource_arn"></a> [resource\_arn](#input\_resource\_arn) | The ARN of the resource to associate with the WAF WebACL (e.g., ALB or API Gateway) | `string` | n/a | yes |
| <a name="input_rule_group_metric_name"></a> [rule\_group\_metric\_name](#input\_rule\_group\_metric\_name) | The metric name for the rule group | `string` | `"ExampleRuleGroup"` | no |
| <a name="input_rule_group_name"></a> [rule\_group\_name](#input\_rule\_group\_name) | The name of the rule group | `string` | `"example-rule-group"` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Scope of the WebACL. Use 'REGIONAL' for ALB, 'CLOUDFRONT' for CloudFront | `string` | `"REGIONAL"` | no |
| <a name="input_web_acl_description"></a> [web\_acl\_description](#input\_web\_acl\_description) | Description for the WAF WebACL | `string` | `"WebACL for securing cloud-native application"` | no |
| <a name="input_web_acl_name"></a> [web\_acl\_name](#input\_web\_acl\_name) | The name of the WAF WebACL | `string` | `"example-web-acl"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->