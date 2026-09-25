variable "aws_region" {
  description = "AWS region used for the Incident #005 lab."
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type used by the API fleet lab."
  type        = string

  # Keep the lab inexpensive.
  # Production instance sizing is evaluated separately in instance-sizing.md.
  default = "t3.micro"
}

variable "target_cpu_utilization" {
  description = "Target average CPU utilization for the ASG target-tracking policy."
  type        = number
  default     = 55
}

variable "estimated_instance_warmup" {
  description = "Seconds before newly launched instances contribute normally to scaling decisions."
  type        = number
  default     = 180
}
