# Creates your private network in AWS
resource "aws_vpc" "this" {

  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "devops-vpc"
  }

}


# Public subnet inside VPC
resource "aws_subnet" "public" {

  vpc_id = aws_vpc.this.id

  cidr_block = var.subnet_cidr

  map_public_ip_on_launch = true

  tags = {
    Name = "devops-public-subnet"
  }

}


# Internet access gateway
resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.this.id

}


# Route table
resource "aws_route_table" "rt" {

  vpc_id = aws_vpc.this.id

}


# Internet route
resource "aws_route" "internet" {

  route_table_id = aws_route_table.rt.id

  destination_cidr_block = "0.0.0.0/0"

  gateway_id = aws_internet_gateway.igw.id

}


# Connect subnet to route table
resource "aws_route_table_association" "assoc" {

  subnet_id = aws_subnet.public.id

  route_table_id = aws_route_table.rt.id

}


# Security group allowing web traffic
resource "aws_security_group" "web" {

  name = "allow_web"

  vpc_id = aws_vpc.this.id


  ingress {

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }


  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }


  tags = {
    Name = "web-security-group"
  }

}