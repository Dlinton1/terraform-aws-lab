# Security group controls inbound/outbound traffic

resource "aws_security_group" "this" {
  name   = "devops-security-group"

  # Attach security group to VPC
  vpc_id = var.vpc_id

  # Allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

    # WARNING:
    # 0.0.0.0/0 means anyone on internet can reach this
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow web traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound internet traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
}