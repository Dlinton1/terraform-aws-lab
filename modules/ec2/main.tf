# Create EC2 instance (virtual machine)
resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y apache2
    sudo systemctl start apache2
    echo "DevOps Server Live" > /var/www/html/index.html
  EOF

  tags = {
    Name = var.instance_name
  }
}