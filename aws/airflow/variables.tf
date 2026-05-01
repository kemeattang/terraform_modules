variable "airflow_version" {
  type = string
  default = null
  description = "Airflow version of your environment"
}

variable "dag_s3_path" {
  type        = string
  default     = "dags/"
  description = "The relative path to the DAG folder on the Amazon S3 storage bucket."
}

variable "name" {
  type        = string
  description = "Name of the associated AWS resources."
}

variable "plugins_s3_path" {
  type        = string
  default     = "plugins.zip"
  description = "The relative path to the plugins archive on the Amazon S3 storage bucket."
}

variable "requirements" {
  type        = string
  default     = null
  description = "The contents of the requirements.txt file. If specified, then the requirements.txt file is installed in your environment."
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "Security groups IDs for the apache airflow environment"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The private subnet IDs in which the environment should be created. MWAA requires two subnets."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources."
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "The VPC ID to create the security group in. If `security_group_ids` are not provided."
}
