# AWS Provider Configuration
# Tells Terraform which cloud provider to use

provider "aws" {

  region = "us-east-1"

}


# Find latest Ubuntu 22.04 AMI automatically
# Prevents hardcoding old images

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = [
    "099720109477"
  ]


  filter {

    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]

  }

}



# Create VPC Infrastructure

module "vpc" {

  source = "./modules/vpc"


  # Network range

  vpc_cidr = "10.0.0.0/16"


  # Public subnet

  subnet_cidr = "10.0.1.0/24"

}




# Create EC2 Server

module "ec2" {

  source = "./modules/ec2"


  # Operating system
  ami_id = data.aws_ami.ubuntu.id


  # Free tier instance size
  instance_type = "t2.micro"


  # Server name
  instance_name = "terraform-dev-server"


  # Place EC2 inside subnet
  subnet_id = module.vpc.public_subnet_id


  # Attach security group from VPC module
  security_group_id = module.vpc.security_group_id

}