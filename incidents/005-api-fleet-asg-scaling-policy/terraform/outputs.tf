output "alb_dns_name" {
  description = "DNS name of the Incident #005 Application Load Balancer."
  value       = aws_lb.api.dns_name
}

output "autoscaling_group_name" {
  description = "Name of the Incident #005 Auto Scaling Group."
  value       = aws_autoscaling_group.api.name
}

output "target_group_arn" {
  description = "ARN of the Incident #005 target group."
  value       = aws_lb_target_group.api.arn
}

output "target_tracking_policy_name" {
  description = "Name of the target-tracking scaling policy."
  value       = aws_autoscaling_policy.api_cpu_target.name
}

output "target_cpu_utilization" {
  description = "Configured target CPU utilization."
  value       = var.target_cpu_utilization
}

output "estimated_instance_warmup" {
  description = "Configured estimated instance warmup."
  value       = var.estimated_instance_warmup
}
