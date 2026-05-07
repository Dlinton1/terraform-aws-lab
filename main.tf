# Configure AWS provider (which cloud + region)
provider "aws" {
  region = "us-east-1"
}

# Get latest Ubuntu AMI automatically (no hardcoding)
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Official Ubuntu owner

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Call VPC module (builds networking)
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

module "ec2" {
  source = "./modules/ec2"

  ami_id         = data.aws_ami.ubuntu.id
  instance_type  = "t2.micro"
  instance_name  = "terraform-dev-server"

subnet_id = module.vpc.public_subnet_id
}