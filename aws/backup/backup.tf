resource "aws_backup_vault" "this" {
  name = local.name
  tags = local.tags
}

resource "aws_backup_vault_policy" "this" {
  backup_vault_name = aws_backup_vault.this.name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "default",
    "Statement" : [
      {
        "Sid" : "default",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "backup:DescribeBackupVault",
          "backup:DeleteBackupVault",
          "backup:PutBackupVaultAccessPolicy",
          "backup:DeleteBackupVaultAccessPolicy",
          "backup:GetBackupVaultAccessPolicy",
          "backup:StartBackupJob",
          "backup:GetBackupVaultNotifications",
          "backup:PutBackupVaultNotifications"
        ],
        "Resource" : "${aws_backup_vault.this.arn}"
      }
    ]
  })
}

resource "aws_backup_plan" "this" {
  name = local.name

  rule {
    rule_name         = local.name
    target_vault_name = aws_backup_vault.this.name
    schedule          = var.schedule

    lifecycle {
      delete_after = var.delete_after
    }
  }
}

resource "aws_backup_selection" "this" {
  iam_role_arn = module.iam.arn
  name         = local.name
  plan_id      = aws_backup_plan.this.id

  resources = var.resources

  dynamic "selection_tag" {
    for_each = [var.selection_tags]
    content {
      type  = selection_tag.value.type
      key   = selection_tag.value.key
      value = selection_tag.value.value
    }
  }
}