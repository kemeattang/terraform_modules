locals {
  bucket_name = "kememwaa-${var.name}"

  tags = merge(
    var.tags,
    {
      module = "aws-airflow"
    }
  )
}
