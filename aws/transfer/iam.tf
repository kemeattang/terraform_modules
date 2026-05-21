module "iam" {
  for_each = local.iteratable_users
  source   = "git@github.com:kemeattang/terraform_modules.git//aws/iam-role?ref=v1.0.0"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "transfer.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  create_instance_profile = false

  name = "${var.name}-${each.key}"

  policies = [
    jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "AllowFullAccesstoCloudWatchLogs",
          "Effect": "Allow",
          "Action": [
            "logs:*"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:ListBucket",
            "s3:GetBucketLocation"
          ],
          "Resource": [
            "arn:aws:s3:::${module.s3.id}"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject",
            "s3:DeleteObjectVersion",
            "s3:GetObjectVersion",
            "s3:GetObjectACL",
            "s3:PutObjectACL"
          ],
          "Resource": [
            "arn:aws:s3:::${module.s3.id}/${each.key}/*"
          ]
        }
      ]
    })
  ]

  tags = local.tags
}

module "transfer_logging" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/iam-role?ref=v1.0.0"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "transfer.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
    }
  )

  create_instance_profile = false

  name = "${var.name}-${random_string.this.result}-logging"

  policies = [
    jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Sid" : "AllowFullAccesstoCloudWatchLogs",
            "Effect" : "Allow",
            "Action" : [
              "logs:CreateLogStream",
              "logs:DescribeLogStreams",
              "logs:CreateLogGroup",
              "logs:PutLogEvents"
            ],
            "Resource" : "*"
          }
        ]
      }
    )
  ]

  tags = local.tags
}

module "superusers_iam" {
  for_each = toset(var.superusers)
  source   = "git@github.com:kemeattang/terraform_modules.git//aws/iam-role?ref=v1.0.0"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "transfer.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  create_instance_profile = false

  name = "${var.name}-${each.key}"

  policies = [
    jsonencode({
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "AllowFullAccesstoCloudWatchLogs",
          "Effect": "Allow",
          "Action": [
            "logs:*"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:ListBucket",
            "s3:GetBucketLocation"
          ],
          "Resource": [
            "arn:aws:s3:::${module.s3.id}"
          ]
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:PutObject",
            "s3:GetObject",
            "s3:DeleteObject",
            "s3:DeleteObjectVersion",
            "s3:GetObjectVersion",
            "s3:GetObjectACL",
            "s3:PutObjectACL"
          ],
          "Resource": [
            "arn:aws:s3:::${module.s3.id}/*"
          ]
        }
      ]
    })
  ]

  tags = local.tags
}