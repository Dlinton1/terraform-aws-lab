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

# Call EC2 module (builds server)
module "ec2" {
  source = "./modules/ec2"

  ami_id        = data.aws_ami.ubuntu.id   # Use latest Ubuntu
  instance_type = "t2.micro"               # Free tier
  subnet_id     = module.vpc.subnet_id     # Connect EC2 to VPC subnet
  instance_name = "terraform-free-lab"
}