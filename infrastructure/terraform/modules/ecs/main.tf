resource "aws_ecs_cluster" "this" {
  name = "${var.project_name}-${var.environment}-cluster"

  tags = {
    Name = "${var.project_name}-${var.environment}-cluster"
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-${var.environment}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

locals {
  services = {
    frontend = {
      image_url        = var.frontend_ecr_repository_url
      target_group_arn = var.frontend_target_group_arn
      log_prefix       = "frontend"
    }

    sales = {
      image_url        = var.sales_ecr_repository_url
      target_group_arn = var.sales_target_group_arn
      log_prefix       = "sales"
    }

    support = {
      image_url        = var.support_ecr_repository_url
      target_group_arn = var.support_target_group_arn
      log_prefix       = "support"
    }
  }
}

resource "aws_ecs_task_definition" "service" {
  for_each = local.services

  family                   = "${var.project_name}-${var.environment}-${each.key}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = var.ecs_cpu
  memory = var.ecs_memory

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "${var.project_name}-${var.environment}-${each.key}"
      image     = "${each.value.image_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = var.ecs_log_group_name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = each.value.log_prefix
        }
      }
    }
  ])
}

resource "aws_ecs_service" "service" {
  for_each = local.services

  name            = "${var.project_name}-${var.environment}-${each.key}-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.service[each.key].arn

  desired_count = var.desired_count
  launch_type   = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = each.value.target_group_arn
    container_name   = "${var.project_name}-${var.environment}-${each.key}"
    container_port   = var.container_port
  }
  service_registries {
  registry_arn = var.service_discovery_service_arns[each.key]
}

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution_role_policy
  ]
}