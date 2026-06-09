# Create EC2 instance (virtual machine)
resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  
    # Attach firewall
  vpc_security_group_ids = [var.security_group_id]

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

# Security Group (Firewall)

resource "aws_security_group" "web_sg" {

  name = "devops-web-sg"

  # Allow inbound HTTP traffic (website traffic)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    # Allow traffic from anywhere
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic to internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-security-group"
  }
}