## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/sns_topic) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [actions](#input\_actions) | Alarm actions for Cloudwatch alert. | object({ok_actions    = list(string)alarm_actions = list(string)})| {"alarm_actions": [],"ok_actions": []}| no |
| [alarm\_description](#input\_alarm\_description) | The description for the alarm. | `string` | `null` | no |
| [comparison\_operator](#input\_comparison\_operator) | The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold. | `string` | `"GreaterThanOrEqualToThreshold"` | no |
| [evaluation\_periods](#input\_evaluation\_periods) | The number of periods over which data is compared to the specified threshold. | `number` | `3` | no |
| [metrics](#input\_metrics) | The metrics configuration for cloudwatch alarm | map(object({namespace   = stringthreshold   = numbermetric_name = stringdimensions  = map(string)}))| n/a | yes |
| [period](#input\_period) | The period in seconds over which the specified statistic is applied. | `string` | `60` | no |
| [sns\_topic\_name](#input\_sns\_topic\_name) | The SNS topic name to send the alarm notification. | `string` | `"infrastructure"` | no |
| [statistic](#input\_statistic) | The statistic to apply to the alarm's associated metric. | `string` | `"Average"` | no |
| [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |
| [unit](#input\_unit) | The unit for the alarm's associated metric. | `string` | `null` | no |

## Outputs

No outputs.
