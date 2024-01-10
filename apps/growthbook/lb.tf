
### Load balancer
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "= 5.13"

  name                        = "${var.environment}-${var.name}"
  internal                    = var.alb_internal
  vpc_id                      = var.vpc_id
  subnets                     = var.alb_subnets
  security_groups             = flatten([aws_security_group.alb.id])
  listener_ssl_policy_default = "ELBSecurityPolicy-TLS-1-2-2017-01"

  target_groups = [
    {
      name             = "${var.environment}-${var.name}-app"
      backend_protocol = "HTTP"
      backend_port     = var.app_port
      target_type      = "ip"
    },
    {
      name             = "${var.environment}-${var.name}-api"
      backend_protocol = "HTTP"
      backend_port     = var.api_port
      target_type      = "ip"
      health_check = {
        port = var.app_port
      }
    },
  ]

  https_listeners = [
    {
      port               = 443
      certificate_arn    = var.alb_ssl_cert_arn
      target_group_index = 0
    },
    {
      port               = var.api_port
      certificate_arn    = var.alb_ssl_cert_arn
      target_group_index = 1
    },
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    },
  ]

  tags = var.tags
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = module.alb.http_tcp_listener_arns[0]

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }
}

### Security groups
# ALB
resource "aws_security_group" "alb" {
  name        = "${var.environment}_${var.name}_alb_sg"
  description = "${var.environment}_${var.name} ALB security group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "alb_external_http_in" {
  count = var.alb_internal ? 0 : 1

  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_external_https_in" {
  count = var.alb_internal ? 0 : 1

  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_external_api_in" {
  count = var.alb_internal ? 0 : 1

  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = var.api_port
  to_port           = var.api_port
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_internal_http_in" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = [var.infrastructure_vpc_cidr]
}

resource "aws_security_group_rule" "alb_internal_https_in" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = [var.infrastructure_vpc_cidr]
}

resource "aws_security_group_rule" "alb_internal_api_in" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = var.api_port
  to_port           = var.api_port
  cidr_blocks       = [var.infrastructure_vpc_cidr]
}

resource "aws_security_group_rule" "alb_all_out" {
  security_group_id = aws_security_group.alb.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# ECS task
resource "aws_security_group" "ecs" {
  name        = "${var.environment}_${var.name}_ecs_sg"
  description = "${var.environment}_${var.name} ECS security group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "ecs_alb_app_in" {
  security_group_id        = aws_security_group.ecs.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.app_port
  to_port                  = var.app_port
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "ecs_alb_api_in" {
  security_group_id        = aws_security_group.ecs.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.api_port
  to_port                  = var.api_port
  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "ecs_all_out" {
  security_group_id = aws_security_group.ecs.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

# Database
resource "aws_security_group" "db" {
  name        = "${var.environment}_${var.name}_db_sg"
  description = "${var.environment}_${var.name} DB security group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "ecs_db_app_in" {
  security_group_id        = aws_security_group.db.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.db_port
  to_port                  = var.db_port
  source_security_group_id = aws_security_group.ecs.id
}

resource "aws_security_group_rule" "db_all_out" {
  security_group_id = aws_security_group.db.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}





