## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| [iam](#module\_iam) | git@github.com:kemeattang/terraform_modules.git//aws/iam-role | v1.1.0 |
| [s3](#module\_s3) | git@github.com:kemeattang/terraform_modules.git//aws/s3 | v1.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_mwaa_environment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment) | resource |
| [aws_s3_bucket_object.requirements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [airflow\_version](#input\_airflow\_version) | Airflow version of your environment | `string` | `null` | no |
| [dag\_s3\_path](#input\_dag\_s3\_path) | The relative path to the DAG folder on the Amazon S3 storage bucket. | `string` | `"dags/"` | no |
| [name](#input\_name) | Name of the associated AWS resources. | `string` | n/a | yes |
| [plugins\_s3\_path](#input\_plugins\_s3\_path) | The relative path to the plugins archive on the Amazon S3 storage bucket. | `string` | `"plugins.zip"` | no |
| [requirements](#input\_requirements) | The contents of the requirements.txt file. If specified, then the requirements.txt file is installed in your environment. | `string` | `null` | no |
| [security\_group\_ids](#input\_security\_group\_ids) | Security groups IDs for the apache airflow environment | `list(string)` | `[]` | no |
| [subnet\_ids](#input\_subnet\_ids) | The private subnet IDs in which the environment should be created. MWAA requires two subnets. | `list(string)` | n/a | yes |
| [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| [vpc\_id](#input\_vpc\_id) | The VPC ID to create the security group in. If `security_group_ids` are not provided. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| [aws\_region](#output\_aws\_region) | The AWS region in which the Airflow environment is deployed. |
| [version](#output\_version) | The provided version for the Apache Airflow environment. |
| [webserver\_url](#output\_webserver\_url) | The URL of the Apache Airflow web server. |
