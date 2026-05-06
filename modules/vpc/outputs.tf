# Output subnet ID so other modules (like EC2) can use it
output "subnet_id" {
  value = aws_subnet.subnet.id
}