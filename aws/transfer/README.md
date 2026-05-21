## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| [aws](#provider\_aws) | n/a |
| [random](#provider\_random) | n/a |
| [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| [iam](#module\_iam) | git@github.com:kemeattang/terraform_modules.git//aws/iam-role | v1.0.0 |
| [route53](#module\_route53) | git@github.com:kemeattang/terraform_modules.git//aws/dns | v0.1.0 |
| [s3](#module\_s3) | git@github.com:kemeattang/terraform_modules.git//aws/s3 | v1.0.0 |
| [superusers\_iam](#module\_superusers\_iam) | git@github.com:kemeattang/terraform_modules.git//aws/iam-role | v1.0.0 |
| [transfer\_logging](#module\_transfer\_logging) | git@github.com:kemeattang/terraform_modules.git//aws/iam-role | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_s3_bucket_object.home_dir](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_object.superuser_objects](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_ssm_parameter.private_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.public_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_transfer_server.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_server) | resource |
| [aws_transfer_ssh_key.superuser_this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_ssh_key) | resource |
| [aws_transfer_ssh_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_ssh_key) | resource |
| [aws_transfer_user.superuser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_user) | resource |
| [aws_transfer_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_user) | resource |
| [random_string.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tls_private_key.superuser](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [domain](#input\_domain) | The domain of the server | `string` | `"termnl.cloud"` | no |
| [enable\_superusers](#input\_enable\_superusers) | Boolean flag to enable or disable the creation of superusers | `bool` | `false` | no |
| [name](#input\_name) | The name of the server | `string` | `"tc-sftp"` | no |
| [sub\_domain](#input\_sub\_domain) | The sub domain of the server | `string` | `"sftp"` | no |
| [superusers](#input\_superusers) | List of superusers | `list(string)` | `[]` | no |
| [tags](#input\_tags) | Tags to assign to the resource | `map(string)` | `{}` | no |
| [users](#input\_users) | List of SFTP users | list(object({username   = stringpublic_key = optional(string, null)}))| `[]` | no |

## Outputs

No outputs.
