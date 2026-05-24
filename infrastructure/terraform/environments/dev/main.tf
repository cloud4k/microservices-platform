module "networking" {
  source = "../../modules/networking"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = var.vpc_cidr

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs

  availability_zones = var.availability_zones

  enable_nat_gateway = var.enable_nat_gateway
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.networking.vpc_id

  container_port = var.container_port
}

module "vpc_endpoints" {
  source = "../../modules/vpc-endpoints"

  project_name = var.project_name
  environment  = var.environment

  aws_region = var.aws_region

  vpc_id = module.networking.vpc_id

  private_subnet_ids = module.networking.private_subnet_ids

  security_group_id = module.security.ecs_security_group_id

  enable_vpc_endpoints    = var.enable_vpc_endpoints
  private_route_table_ids = module.networking.private_route_table_ids
}

module "ecr" {
  source = "../../modules/ecr"

  project_name = var.project_name
  environment  = var.environment
}

module "observability" {
  source = "../../modules/observability"

  project_name       = var.project_name
  environment        = var.environment
  log_retention_days = var.log_retention_days
}

module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids

  alb_security_group_id = module.security.alb_security_group_id

  container_port    = var.container_port
  health_check_path = var.health_check_path
}

module "ecs" {
  source = "../../modules/ecs"

  project_name = var.project_name
  environment  = var.environment

  aws_region = var.aws_region

  ecs_cpu       = var.ecs_cpu
  ecs_memory    = var.ecs_memory
  desired_count = var.desired_count

  container_port = var.container_port

  private_subnet_ids = module.networking.private_subnet_ids

  ecs_security_group_id = module.security.ecs_security_group_id

  target_group_arn = module.alb.target_group_arn

  ecr_repository_url = module.ecr.repository_url

  ecs_log_group_name = module.observability.ecs_log_group_name
}