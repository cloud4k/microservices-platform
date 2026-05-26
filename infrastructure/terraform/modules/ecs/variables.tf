variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "ecs_cpu" {
  type = number
}

variable "ecs_memory" {
  type = number
}

variable "desired_count" {
  type = number
}

variable "container_port" {
  type = number
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "frontend_target_group_arn" {
  type = string
}

variable "sales_target_group_arn" {
  type = string
}

variable "support_target_group_arn" {
  type = string
}

variable "frontend_ecr_repository_url" {
  type = string
}

variable "sales_ecr_repository_url" {
  type = string
}

variable "support_ecr_repository_url" {
  type = string
}

variable "ecs_log_group_name" {
  type = string
}