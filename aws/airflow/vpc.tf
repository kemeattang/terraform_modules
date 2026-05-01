resource "aws_security_group" "this" {
  count = length(var.security_group_ids) > 0 ? 0 : 1

  name        = "${var.name}"
  description = "AWS MWAA Security Group"

  vpc_id = var.vpc_id

  ingress {
    description      = "HTTPS from the internet."
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "All traffic from the SG"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = local.tags
}
