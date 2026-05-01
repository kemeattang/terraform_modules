output "aws_region" {
  description = "The AWS region in which the Airflow environment is deployed."
  value       = data.aws_region.this.name
}

output "version" {
  description = "The provided version for the Apache Airflow environment."
  value = var.airflow_version
}

output "webserver_url" {
  description = "The URL of the Apache Airflow web server."
  value       = aws_mwaa_environment.this.webserver_url
}
