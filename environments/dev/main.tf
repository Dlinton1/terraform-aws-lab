# Pull latest Ubuntu AMI dynamically
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# VPC MODULE
# Creates networking infrastructure for AWS

module "vpc" {
  source = "../../modules/vpc"

  # Main private network range
  vpc_cidr = "10.0.0.0/16"

  # Smaller network inside VPC
  subnet_cidr = "10.0.1.0/24"
}

# EC2 MODULE
# This calls our reusable EC2 template from ../../modules/ec2
module "ec2" {
  source = "../../modules/ec2"

  # Operating system image
  ami_id = data.aws_ami.ubuntu.id

  # Free tier server size
  instance_type = "t2.micro"

  # Which subnet to place server into
  subnet_id = module.vpc.public_subnet_id

  # Name shown in AWS console
  instance_name = "terraform-dev-server"
}