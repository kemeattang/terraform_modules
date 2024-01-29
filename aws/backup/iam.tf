module "iam" {
  source = "../iam-role"
  name   = "${local.name}-role"

  custom_role_trust_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : ["sts:AssumeRole"],
        "Effect" : "allow",
        "Principal" : {
          "Service" : ["backup.amazonaws.com"]
        }
      }
    ]
  })

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  ]

  create_instance_profile = false

  tags = var.tags
}
