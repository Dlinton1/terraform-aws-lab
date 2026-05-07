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
  source = "../../modules/ec2"

  # AMI for EC2 instance
  ami_id = data.aws_ami.ubuntu.id

  # Name tag for EC2 instance
  instance_name = "terraform-dev-server"

  # Optional depending on your module (ONLY include if module supports it)
  vpc_security_group_id = module.vpc.default_security_group_id
}