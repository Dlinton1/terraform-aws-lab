# Output EC2 public IP from module
output "public_ip" {
  value = module.ec2.public_ip
}