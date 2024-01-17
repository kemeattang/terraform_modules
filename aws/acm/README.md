## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| [dns](#module\_dns) | ../dns | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.local](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.local](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [domain](#input\_domain) | The name of domain to use. | `string` | `""` | no |
| [enable\_validation](#input\_enable\_validation) | Set to prevent validation of  DNS and EMAIL. | `bool` | `true` | no |
| [sub\_domain](#input\_sub\_domain) | The name of sub domain to use. | `string` | `""` | no |
| [tags](#input\_tags) | A map of tags to assign to the ACM. | `map(string)` | `{}` | no |
| [target\_region](#input\_target\_region) | The region to create the certificate in. | `string` | `"global"` | no |
| [validation\_method](#input\_validation\_method) | For validation, DNS or EMAIL. | `string` | `"DNS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | The ARN of the certificate |
| [domain\_name](#output\_domain\_name) | The name of the domain |
