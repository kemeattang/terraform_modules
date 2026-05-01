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
| [aws_s3_bucket.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_ownership_controls.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [random_uuid.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [acl](#input\_acl) | ACL for S3 bucket | `string` | `"private"` | no |
| [bucket\_key\_enabled](#input\_bucket\_key\_enabled) | Whether or not to use Amazon S3 Bucket Keys for SSE-KMS. | `bool` | `true` | no |
| [bucket\_policy](#input\_bucket\_policy) | S3 Bucket policy. | map(object({effect = stringprincipals = list(object({type        = stringidentifiers = list(string)}))actions   = list(string)resources = list(string)}))| `null` | no |
| [enable\_logging](#input\_enable\_logging) | Enable logging for S3 bucket | `bool` | `true` | no |
| [error](#input\_error) | The default error html file, An absolute path to the document to return in case of a error | `string` | `"error.html"` | no |
| [index](#input\_index) | Default index document to host static website | `string` | `"index.html"` | no |
| [lifecycle\_rules](#input\_lifecycle\_rules) | A map of lifecycle rules. WARNING: Check https://aws.amazon.com/s3/pricing/ for lifecycle transition pricing before adding a lifecycle. | map(object({id                                     = stringprefix                                 = stringenabled                                = boolabort_incomplete_multipart_upload_days = stringexpiration_inputs = list(object({date                         = stringdays                         = numberexpired_object_delete_marker = string}))transition_inputs = list(object({date          = stringdays          = numberstorage_class = string}))noncurrent_version_transition_inputs = list(object({days          = numberstorage_class = string}))noncurrent_version_expiration_inputs = list(object({days = number}))}))| `{}` | no |
| [name](#input\_name) | The name of the s3 bucket | `string` | `null` | no |
| [s3\_website](#input\_s3\_website) | Whether or not to use Amazon S3 Bucket Website | `bool` | `false` | no |
| [sse\_algorithm](#input\_sse\_algorithm) | The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`. | `string` | `"AES256"` | no |
| [tags](#input\_tags) | The tags of the s3 bucket | `map(string)` | `{}` | no |
| [versioning](#input\_versioning) | Enable versioning for S3 bucket | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| [arn](#output\_arn) | S3 Bucket ARN. |
| [id](#output\_id) | The id of s3 bucket. |
| [s3\_get\_policy\_json](#output\_s3\_get\_policy\_json) | S3 get policy json. |
