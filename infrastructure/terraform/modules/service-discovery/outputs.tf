output "namespace_id" {
  value = aws_service_discovery_private_dns_namespace.this.id
}

output "namespace_name" {
  value = aws_service_discovery_private_dns_namespace.this.name
}

output "service_arns" {
  value = {
    frontend = aws_service_discovery_service.frontend.arn
    sales    = aws_service_discovery_service.sales.arn
    support  = aws_service_discovery_service.support.arn
  }
}
