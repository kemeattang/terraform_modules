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
| [aws_route53_record.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.single](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [alias](#input\_alias) | boolean used to determin if a hosted zone should be created. | `bool` | `false` | no |
| [aliasrecord](#input\_aliasrecord) | A record to create as a part of an upstream terraform module.  This can oly create one record for alias. This is not recommended to be used in tandem with `var.records`. | object({name    = stringtype    = string})| `null` | no |
| [create\_hosted\_zone](#input\_create\_hosted\_zone) | boolean used to determin if a hosted zone should be created. | `bool` | `true` | no |
| [domain](#input\_domain) | The domain name to use for the hosted zone. | `string` | n/a | yes |
| [evaluate\_target\_health](#input\_evaluate\_target\_health) | Set to true if you want Route 53 to determine whether to respond to DNS queries | `bool` | `false` | no |
| [record](#input\_record) | A record to create as a part of an upstream terraform module.  This can oly create one record. This is not recommended to be used in tandem with `var.records`. | object({name    = stringtype    = stringttl     = numberrecords = list(string)})| `null` | no |
| [records](#input\_records) | A map of record types to a list of records. The key will be used for the record name, while the value object will be used for ttl, type, and record values.  This is not recommended to be used in tandem with `var.records`. | map(object({type    = stringttl     = numberrecords = list(string)}))| `{}` | no |
| [tags](#input\_tags) | Tags to apply to the resource | `map(string)` | `{}` | no |
| [target\_dns\_name](#input\_target\_dns\_name) | DNS name of target resource (e.g. ALB, ELB) | `string` | n/a | yes |
| [target\_zone\_id](#input\_target\_zone\_id) | ID of target resource (e.g. ALB, ELB) | `string` | n/a | yes |
| [zone\_id](#input\_zone\_id) | The zone id to use for the record | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| [fqdn](#output\_fqdn) | Fully-qualified domain name value |
| [name\_servers](#output\_name\_servers) | Route53 DNS Zone Name Servers |
| [zone\_id](#output\_zone\_id) | Route53 DNS Zone ID |
