## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| [aws](#provider\_aws) | n/a |
| [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.managed_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_uuid.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [assume\_role\_policy](#input\_assume\_role\_policy) | Policy that grants an entity permission to assume the role | `string` | `"{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Action\": \"sts:AssumeRole\"\n    }\n  ]\n}\n"` | no |
| [create\_instance\_profile](#input\_create\_instance\_profile) | Boolean to create an instance profile for the role | `bool` | `true` | no |
| [managed\_policy\_arns](#input\_managed\_policy\_arns) | Set of exclusive IAM managed policy ARNs to attach to the IAM role. | `list(string)` | `[]` | no |
| [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| [name](#input\_name) | Friendly name of the role. | `string` | `null` | no |
| [path](#input\_path) | Path to the role. | `string` | `null` | no |
| [policies](#input\_policies) | Policy document as a JSON formatted string. | `list(string)` | `[]` | no |
| [tags](#input\_tags) | Key-value mapping of tags for the IAM role | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| [arn](#output\_arn) | n/a |
| [instance\_profile](#output\_instance\_profile) | n/a |
| [name](#output\_name) | n/a |
