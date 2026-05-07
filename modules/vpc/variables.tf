# VPC network range
# Example:
# 10.0.0.0/16

# Subnet inside the VPC
# Example:
# 10.0.1.0/24

# VPC CIDR (main network range)
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

# Subnet CIDR (smaller network inside VPC)
variable "subnet_cidr" {
  description = "CIDR block for subnet"
  type        = string
}