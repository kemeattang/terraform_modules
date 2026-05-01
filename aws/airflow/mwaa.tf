resource "aws_mwaa_environment" "this" {
  name = var.name

  airflow_version = var.airflow_version

  execution_role_arn = module.iam.arn

  dag_s3_path          = var.dag_s3_path
  plugins_s3_path      = var.plugins_s3_path
  requirements_s3_path = var.requirements != null ? aws_s3_bucket_object.requirements[0].id : null

  logging_configuration {
    dag_processing_logs {
      enabled   = true
      log_level = "INFO"
    }

    scheduler_logs {
      enabled   = true
      log_level = "INFO"
    }

    task_logs {
      enabled   = true
      log_level = "INFO"
    }

    webserver_logs {
      enabled   = true
      log_level = "INFO"
    }

    worker_logs {
      enabled   = true
      log_level = "INFO"
    }
  }

  webserver_access_mode = "PUBLIC_ONLY"

  network_configuration {
    security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : [aws_security_group.this[0].id]
    subnet_ids         = var.subnet_ids
  }

  source_bucket_arn = module.s3.arn

  tags = local.tags
}
