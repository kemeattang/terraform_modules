locals {
  env_variables = [
    {
      name  = "S3_BUCKET"
      value =  var.s3_bucket_name
    },
    {
      name  = "S3_REGION"
      value = var.s3_region
    },
    {
      name  = "MONGODB_URI"
      value = "mongodb://${var.db_username}:${random_password.db_password.result}@${aws_docdb_cluster.this.endpoint}:${var.db_port}/?retryWrites=false&directConnection=true&tls=true&tlsCAFile=/usr/local/src/app/rds-combined-ca-bundle.pem"
    },
    {
      name  = "APP_ORIGIN"
      value = "https://${var.host_name}.${var.domain}"
    },
    {
      name  = "CORS_ORIGIN_REGEX"
      value = "https://${var.host_name}.${var.domain}*"
    },
    {
      name  = "API_HOST"
      value = "https://${var.host_name}.${var.domain}:3100"
    },
    {
      name  = "NODE_ENV"
      value = "production"
    },
    {
      name  = "JWT_SECRET"
      value = random_password.jwt_secret.result
    },
    {
      name  = "ENCRYPTION_KEY"
      value = random_password.encryption_key.result
    }
  ]
  tags = merge(
    var.tags,
    {
      module = "growthbook"
    }
  )
}