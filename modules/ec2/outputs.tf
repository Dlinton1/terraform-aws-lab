# Output public IP so we can access the server
output "public_ip" {
  value = aws_instance.app.public_ip
}