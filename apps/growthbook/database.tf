### Database
resource "aws_docdb_cluster" "this" {
  cluster_identifier              = "${var.environment}-${var.name}"
  master_username                 = var.db_username
  master_password                 = random_password.db_password.result
  engine                          = var.engine
  engine_version                  = var.engine_version
  port                            = var.db_port
  backup_retention_period         = var.retention_period
  skip_final_snapshot             = var.skip_final_snapshot
  deletion_protection             = var.deletion_protection
  apply_immediately               = var.apply_immediately
  storage_encrypted               = var.storage_encrypted
  kms_key_id                      = var.kms_key_id
  vpc_security_group_ids          = [aws_security_group.db.id]
  db_subnet_group_name            = aws_docdb_subnet_group.this.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.this.name
  tags                            = var.tags
}

resource "aws_docdb_cluster_instance" "this" {
  count = var.cluster_size

  identifier                 = "${var.environment}-${var.name}-${count.index + 1}"
  cluster_identifier         = aws_docdb_cluster.this.id
  apply_immediately          = var.apply_immediately
  instance_class             = var.instance_class
  engine                     = var.engine
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  tags                       = var.tags
}

resource "aws_docdb_subnet_group" "this" {
  name        = "${var.environment}-${var.name}"
  description = "Allowed subnets for DB cluster instances"
  subnet_ids  = var.ecs_subnets
  tags        = var.tags
}

# https://docs.aws.amazon.com/documentdb/latest/developerguide/db-cluster-parameter-group-create.html
resource "aws_docdb_cluster_parameter_group" "this" {
  name        = "${var.environment}-${var.name}"
  description = "DB cluster parameter group"
  family      = var.cluster_family
  tags        = var.tags

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      apply_method = lookup(parameter.value, "apply_method", null)
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
}
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "./_"
}

resource "aws_ssm_parameter" "database_credentials" {
  name        = "/${var.environment}/growthbookdatabase/credentials"
  description = "The parameter description"
  type        = "SecureString"
  value       = "${var.db_username}:${random_password.db_password.result}"

  tags = {
    environment = var.environment
  }
}

