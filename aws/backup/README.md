## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| [aws](#provider\_aws) | n/a |
| [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| [iam](#module\_iam) | ../iam-role | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_backup_plan.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_plan) | resource |
| [aws_backup_selection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_selection) | resource |
| [aws_backup_vault.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault) | resource |
| [aws_backup_vault_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/backup_vault_policy) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [delete\_after](#input\_delete\_after) | How long to store the backup | `number` | `30` | no |
| [name](#input\_name) | The name of the server | `string` | `null` | no |
| [resources](#input\_resources) | An array of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan. | `list(string)` | `null` | no |
| [schedule](#input\_schedule) | Schedule for backup | `string` | `"cron(0 12 * * ? *)"` | no |
| [selection\_tags](#input\_selection\_tags) | A mapping of key-value pairs that is used to identify resources that are associated with this rule. | object({type  = stringkey   = stringvalue = string})| {"key": "aws_backup","type": "STRINGEQUALS","value": "true"}| no |
| [tags](#input\_tags) | Tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

No outputs.
