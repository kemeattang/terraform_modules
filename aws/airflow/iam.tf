module "iam" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/iam-role?ref=v1.1.0"

  name = var.name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "airflow.amazonaws.com",
            "airflow-env.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  policies = [
    jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "airflow:PublishMetrics",
          "Resource" : "arn:aws:airflow:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:environment/${var.name}"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject*",
            "s3:GetBucket*",
            "s3:List*"
          ],
          "Resource" : [
            "arn:aws:s3:::${local.bucket_name}",
            "arn:aws:s3:::${local.bucket_name}/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogStream",
            "logs:CreateLogGroup",
            "logs:PutLogEvents",
            "logs:GetLogEvents",
            "logs:GetLogRecord",
            "logs:GetLogGroupFields",
            "logs:GetQueryResults"
          ],
          "Resource" : [
            "arn:aws:logs:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:log-group:airflow-${var.name}-*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:DescribeLogGroups"
          ],
          "Resource" : [
            "*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetAccountPublicAccessBlock"
          ],
          "Resource" : [
            "*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "glue:*",
            "athena:StartQueryExecution",
            "athena:GetQueryExecution",
            "athena:GetQueryResults"
          ],
          "Resource" : [
            "*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "cloudwatch:PutMetricData",
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "sqs:ChangeMessageVisibility",
            "sqs:DeleteMessage",
            "sqs:GetQueueAttributes",
            "sqs:GetQueueUrl",
            "sqs:ReceiveMessage",
            "sqs:SendMessage"
          ],
          "Resource" : "arn:aws:sqs:${data.aws_region.this.name}:*:airflow-celery-*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "kms:Decrypt",
            "kms:DescribeKey",
            "kms:GenerateDataKey*",
            "kms:Encrypt"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringLike" : {
              "kms:ViaService" : [
                "sqs.${data.aws_region.this.name}.amazonaws.com",
                "s3.${data.aws_region.this.name}.amazonaws.com"
              ]
            }
          }
        }
      ]
    })
  ]

  tags = local.tags
}
