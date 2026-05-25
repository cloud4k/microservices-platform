aws_region   = "us-east-1"
project_name = "microservices-platform"
environment  = "dev"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

ecs_cpu        = 256
ecs_memory     = 512
desired_count  = 1
container_port = 5000

enable_nat_gateway   = false
enable_vpc_endpoints = true

log_retention_days = 7

health_check_path = "/health"

min_capacity     = 1
max_capacity     = 3
cpu_target_value = 70
