provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.subnet_id
  name          = "terraform-modules-lab"
}