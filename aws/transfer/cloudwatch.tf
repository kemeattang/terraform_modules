resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/transfer/${aws_transfer_server.this.id}"

  tags = local.tags
}