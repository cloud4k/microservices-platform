output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "ecs_service_names" {
  value = {
    for service_name, service in aws_ecs_service.service :
    service_name => service.name
  }
}
