### Task defination
module "container_definition" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "~> 0.58.1"

  container_name               = "${var.environment}_${var.name}"
  container_image              = "${var.image_name}:${var.image_tag}"
  command                      = ["bash", "-c", "wget https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem && yarn start"]
  container_memory             = var.ecs_task_memory
  container_memory_reservation = var.container_memory_reservation
  container_cpu                = var.ecs_task_cpu
  secrets                      = var.environment_secrets

  environment = concat(
    local.env_variables,
    var.environment_variables,
  )

  port_mappings = [
    {
      containerPort = var.app_port
      hostPort      = var.app_port
      protocol      = "tcp"
    },
    {
      containerPort = var.api_port
      hostPort      = var.api_port
      protocol      = "tcp"
    },
  ]

  log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-region"        = "us-west-2"
      "awslogs-group"         = aws_cloudwatch_log_group.this.name
      "awslogs-stream-prefix" = var.name
    }
    secretOptions = null
  }

  depends_on = [aws_docdb_cluster.this, aws_docdb_cluster_instance.this]
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.environment}_${var.name}"
  container_definitions    = "[${module.container_definition.json_map_encoded}]"
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory
  execution_role_arn       = aws_iam_role.this.arn
  task_role_arn            = aws_iam_role.this.arn
  tags                     = var.tags
}

resource "aws_ecs_service" "service" {
  name                               = "${var.environment}_${var.name}"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = "${aws_ecs_task_definition.this.family}:${aws_ecs_task_definition.this.revision}"
  desired_count                      = var.desired_tasks_count
  launch_type                        = var.launch_type
  deployment_maximum_percent         = var.ecs_service_deployment_maximum_percent
  deployment_minimum_healthy_percent = var.ecs_service_deployment_minimum_healthy_percent

  network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = var.ecs_subnets
    assign_public_ip = var.ecs_assign_public_ip
  }

  load_balancer {
    target_group_arn = element(module.alb.target_group_arns, 0)
    container_name   = "${var.environment}_${var.name}"
    container_port   = var.app_port
  }

  load_balancer {
    target_group_arn = element(module.alb.target_group_arns, 1)
    container_name   = "${var.environment}_${var.name}"
    container_port   = var.api_port
  }

  depends_on = [module.alb, aws_ecs_task_definition.this, aws_docdb_cluster.this, aws_docdb_cluster_instance.this]
}

# === ECS CLUSTER =======================================
  resource "aws_ecs_cluster" "ecs_cluster" {
    name    = var.name
    tags    = local.tags
    
    setting {
      name  = "containerInsights"
      value = "enabled"
    }
  }
  
  resource "aws_ecs_cluster_capacity_providers" "capacity_providers" {
    cluster_name = aws_ecs_cluster.ecs_cluster.name
    
    capacity_providers = [
      "FARGATE",
      "FARGATE_SPOT",
    ]
  }

resource "random_password" "jwt_secret" {
  length           = 32
  special          = true
  override_special = "./_"
}

resource "aws_ssm_parameter" "jwt_credentials" {
  name        = "/${var.environment}/growthbook/jwt_secret"
  description = "The parameter description"
  type        = "SecureString"
  value       = "jwt_secret:${random_password.jwt_secret.result}"

  tags = local.tags
}

resource "random_password" "encryption_key" {
  length           = 32
  special          = true
  override_special = "./_"
}

resource "aws_ssm_parameter" "encryption_credentials" {
  name        = "/${var.environment}/growthbook/encryption_key"
  description = "The parameter description"
  type        = "SecureString"
  value       = "encryption_key:${random_password.encryption_key.result}"

  tags = local.tags
}