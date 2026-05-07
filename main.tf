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
}

module "ec2" {

  # Use EC2 module folder
  source = "./modules/ec2"

  # Latest Ubuntu AMI from AWS
  ami_id = data.aws_ami.ubuntu.id

  # Free-tier server size
  instance_type = "t2.micro"

  # Put EC2 inside VPC subnet
  subnet_id = module.vpc.subnet_id

  # Name shown in AWS console
  instance_name = "terraform-free-lab"
}