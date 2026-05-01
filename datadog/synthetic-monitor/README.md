## Requirements

| Name | Version |
|------|---------|
| [datadog](#requirement\_datadog) | 3.2.0 |

## Providers

| Name | Version |
|------|---------|
| [datadog](#provider\_datadog) | 3.2.0 |
| [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [datadog_synthetics_test.this](https://registry.terraform.io/providers/DataDog/datadog/3.2.0/docs/resources/synthetics_test) | resource |
| [random_uuid.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [assertions](#input\_assertions) | Assertions used for the test | list(object({type   = stringoperator = stringtarget = string}))| [{"operator": "is","target": "200","type": "statusCode"}]| no |
| [locations](#input\_locations) | List of locations used to run the test. | `list(string)` | ["aws:us-east-2"]| no |
| [method](#input\_method) | Type of method used | `string` | `"GET"` | no |
| [name](#input\_name) | Name of Datadog synthetics test. | `string` | `null` | no |
| [notification\_list](#input\_notification\_list) | Channels to get notified | `list(string)` | `[]` | no |
| [options\_list](#input\_options\_list) | Options used for the test | list(object({tick_every       = numberfollow_redirects = boolretry = object({count    = numberinterval = number})monitor_options = object({renotify_interval = number})}))| [{"follow_redirects": true,"monitor_options": {"renotify_interval": 720},"retry": {"count": 1,"interval": 30},"tick_every": 60}]| no |
| [request\_headers](#input\_request\_headers) | Header name and value map. | `map(string)` | {"Content-Type": "application/json"}| no |
| [subtype](#input\_subtype) | The subtype of the Synthetic API test. | `string` | `"http"` | no |
| [tags](#input\_tags) | A list of tags to associate with your synthetics test. | `list(string)` | `[]` | no |
| [type](#input\_type) | Synthetics test type. | `string` | `"api"` | no |
| [url](#input\_url) | URl used for the test | `string` | `"https://supremeecom.com"` | no |

## Outputs

| Name | Description |
|------|-------------|
| [name](#output\_name) | n/a |
