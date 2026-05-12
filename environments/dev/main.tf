data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

module "security_group" {
  source = "../../modules/security-group"

  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "../../modules/ec2"

  ami_id        = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnet_id
  instance_name = "terraform-dev-server"

  security_group_id = module.security_group.security_group_id
}