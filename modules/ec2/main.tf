# EC2 instance resource (creates the server in AWS)
resource "aws_instance" "this" {

  ami           = var.ami_id        # OS image (Ubuntu, Amazon Linux, etc.)
  instance_type = var.instance_type # Size of server (t2.micro = free tier)

  subnet_id     = var.subnet_id     # Where the server lives (inside VPC network)

  tags = {
    Name = var.instance_name        # Label for easy AWS identification
  }
}