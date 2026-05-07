# EC2 MODULE INPUTS
# These are values the EC2 module needs to create a server

# AMI = operating system image (Ubuntu, etc.)
variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

# Instance size (free tier = t2.micro)
variable "instance_type" {
  description = "EC2 size"
  type        = string
}

# Where the server lives inside AWS network (VPC subnet)
variable "subnet_id" {
  description = "Subnet for EC2"
  type        = string
}

# Name tag shown in AWS console (just a label)
variable "instance_name" {
  description = "EC2 name tag"
  type        = string
}