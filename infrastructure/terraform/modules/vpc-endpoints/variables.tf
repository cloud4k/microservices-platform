variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "aws_region" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "enable_vpc_endpoints" {
  type = bool
}
variable "private_route_table_ids" {
  type = list(string)
}