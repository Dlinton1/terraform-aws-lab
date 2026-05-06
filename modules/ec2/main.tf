# Create EC2 instance (virtual machine)
resource "aws_instance" "app" {
  ami           = var.ami_id        # OS image (Ubuntu)
  instance_type = var.instance_type # Size (free tier = t2.micro)
  subnet_id     = var.subnet_id     # Which network to place it in

  tags = {
    Name = var.instance_name # Name shown in AWS console
  }
}