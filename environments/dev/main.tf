module "ec2" {
  source = "../../modules/ec2"

  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.subnet_id
  security_group_id = module.vpc.security_group_id
  name              = "terraform-dev-server"
}