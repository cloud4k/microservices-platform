output "alb_arn" {
  value = aws_lb.this.arn
}

output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.frontend.arn
}

output "sales_target_group_arn" {
  value = aws_lb_target_group.sales.arn
}

output "support_target_group_arn" {
  value = aws_lb_target_group.support.arn
}