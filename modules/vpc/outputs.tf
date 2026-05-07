# Exposes the subnet ID from this module so other modules (like EC2) can use it
output "subnet_id" {
  # Returns the ID of the subnet we created in the VPC module
  value = aws_subnet.subnet.id
}