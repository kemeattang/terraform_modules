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
| [alb](#module\_alb) | terraform-aws-modules/alb/aws | = 5.13 |
| [container\_definition](#module\_container\_definition) | cloudposse/ecs-container-definition/aws | ~> 0.58.1 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_docdb_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster) | resource |
| [aws_docdb_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_instance) | resource |
| [aws_docdb_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group) | resource |
| [aws_docdb_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_subnet_group) | resource |
| [aws_ecs_cluster.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.capacity_providers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lb_listener_rule.redirect_http_to_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_route53_record.growthbook](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.alb_all_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_external_api_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_external_http_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_external_https_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_internal_api_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_internal_http_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_internal_https_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_all_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_alb_api_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_alb_app_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_all_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_db_app_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.database_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.encryption_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.jwt_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.encryption_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.jwt_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_uuid.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [alb\_internal](#input\_alb\_internal) | Boolean determining if the load balancer is internal or externally facing. | `bool` | `false` | no |
| [alb\_ssl\_cert\_arn](#input\_alb\_ssl\_cert\_arn) | The ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. | `string` | `""` | no |
| [alb\_subnets](#input\_alb\_subnets) | A list of IDs of existing subnets inside the VPC | `list(string)` | `[]` | no |
| [api\_port](#input\_api\_port) | Local port growthbook api should be running on | `number` | `3100` | no |
| [app\_port](#input\_app\_port) | Local port growthbook app should be running on | `number` | `3000` | no |
| [apply\_immediately](#input\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window | `bool` | `true` | no |
| [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Specifies whether any minor engine upgrades will be applied automatically to the DB instance during the maintenance window or not | `bool` | `true` | no |
| [cloudwatch\_log\_retention\_in\_days](#input\_cloudwatch\_log\_retention\_in\_days) | Retention period of growthbook CloudWatch logs | `number` | `7` | no |
| [cluster\_family](#input\_cluster\_family) | The family of the DocumentDB cluster parameter group. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-parameter-group-create.html | `string` | `"docdb4.0"` | no |
| [cluster\_parameters](#input\_cluster\_parameters) | List of DB parameters to apply | list(object({apply_method = stringname         = stringvalue        = string}))| `[]` | no |
| [cluster\_size](#input\_cluster\_size) | Number of DB instances to create in the cluster | `number` | `1` | no |
| [container\_memory\_reservation](#input\_container\_memory\_reservation) | The amount of memory (in MiB) to reserve for the container | `number` | `128` | no |
| [db\_password](#input\_db\_password) | (Required unless a snapshot\_identifier is provided) Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. Please refer to the DocumentDB Naming Constraints | `string` | `"password"` | no |
| [db\_port](#input\_db\_port) | DocumentDB port | `number` | `27017` | no |
| [db\_username](#input\_db\_username) | (Required unless a snapshot\_identifier is provided) Username for the master DB user | `string` | `"growthbook_admin"` | no |
| [deletion\_protection](#input\_deletion\_protection) | A value that indicates whether the DB cluster has deletion protection enabled | `bool` | `false` | no |
| [desired\_tasks\_count](#input\_desired\_tasks\_count) | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| [domain](#input\_domain) | The domain name to use for the hosted zone. | `string` | n/a | yes |
| [ecs\_assign\_public\_ip](#input\_ecs\_assign\_public\_ip) | Should be true, if ECS service is using public subnets (more info: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_cannot_pull_image.html) | `bool` | `false` | no |
| [ecs\_service\_deployment\_maximum\_percent](#input\_ecs\_service\_deployment\_maximum\_percent) | The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment | `number` | `200` | no |
| [ecs\_service\_deployment\_minimum\_healthy\_percent](#input\_ecs\_service\_deployment\_minimum\_healthy\_percent) | The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment | `number` | `50` | no |
| [ecs\_subnets](#input\_ecs\_subnets) | A list of IDs of existing subnets inside the VPC | `list(string)` | `[]` | no |
| [ecs\_task\_cpu](#input\_ecs\_task\_cpu) | The number of cpu units used by the task | `number` | `256` | no |
| [ecs\_task\_memory](#input\_ecs\_task\_memory) | The amount (in MiB) of memory used by the task | `number` | `512` | no |
| [engine](#input\_engine) | The name of the database engine to be used for this DB cluster. Defaults to `docdb`. Valid values: `docdb` | `string` | `"docdb"` | no |
| [engine\_version](#input\_engine\_version) | The version number of the database engine to use | `string` | `"4.0.0"` | no |
| [environment](#input\_environment) | Name of the environment | `any` | n/a | yes |
| [environment\_secrets](#input\_environment\_secrets) | List of additional secrets the container will use (list should contain maps with `name` and `valueFrom`) | `list(map(string))` | `[]` | no |
| [environment\_variables](#input\_environment\_variables) | List of additional environment variables the container will use (list should contain maps with `name` and `value`) | `list(map(string))` | `[]` | no |
| [host\_name](#input\_host\_name) | Hostname for growthbook eg feature-flags | `string` | `"feature-flags"` | no |
| [image\_name](#input\_image\_name) | Docker image to run growthbook with | `string` | `"growthbook/growthbook"` | no |
| [image\_tag](#input\_image\_tag) | Verion of growthbook to run. If not specified latest will be used | `string` | `"latest"` | no |
| [infrastructure\_vpc\_cidr](#input\_infrastructure\_vpc\_cidr) | The CIDR of the VPC to allow internal traffic | `string` | `""` | no |
| [instance\_class](#input\_instance\_class) | The instance class to use. For more details, see https://docs.aws.amazon.com/documentdb/latest/developerguide/db-instance-classes.html#db-instance-class-specs | `string` | `"db.t4g.medium"` | no |
| [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. When specifying `kms_key_id`, `storage_encrypted` needs to be set to `true` | `string` | `""` | no |
| [launch\_type](#input\_launch\_type) | The launch type on which to run your service. The valid values are EC2 and FARGATE. | `string` | `"FARGATE"` | no |
| [name](#input\_name) | n/a | `string` | `"growthbook"` | no |
| [network\_mode](#input\_network\_mode) | The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host. | `string` | `"awsvpc"` | no |
| [requires\_compatibilities](#input\_requires\_compatibilities) | A set of launch types required by the task. The valid values are EC2 and FARGATE. | `list(string)` | ["FARGATE"]| no |
| [retention\_period](#input\_retention\_period) | Number of days to retain backups for | `number` | `7` | no |
| [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name of the S3 bucket to store uploaded files and screenshots | `string` | `null` | no |
| [s3\_region](#input\_s3\_region) | Region of the S3 bucket | `string` | `"us-west-2"` | no |
| [security\_group\_ids](#input\_security\_group\_ids) | List of one or more security groups to be added to the load balancer | `list(string)` | `[]` | no |
| [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final DB snapshot is created before the DB cluster is deleted | `bool` | `true` | no |
| [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB cluster is encrypted | `bool` | `true` | no |
| [tags](#input\_tags) | The tags to append to this resource | `map(string)` | `{}` | no |
| [vpc\_id](#input\_vpc\_id) | The identifier of the VPC in which to create resources | `string` | `""` | no |

## Outputs

No outputs.
