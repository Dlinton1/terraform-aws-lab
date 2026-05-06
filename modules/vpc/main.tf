# Create a VPC (your own private network in AWS)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Defines IP range for the network
}

# Create a subnet inside the VPC
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.main.id # Connect subnet to VPC
  cidr_block              = "10.0.1.0/24"   # Smaller IP range inside VPC
  map_public_ip_on_launch = true            # Gives instances public IPs
}

# Create Internet Gateway (allows internet access)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id # Attach to VPC
}

# Create Route Table (controls traffic rules)
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
}

# Add route to internet (0.0.0.0 = everywhere)
resource "aws_route" "route" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"           # All traffic
  gateway_id             = aws_internet_gateway.gw.id # Send to internet
}

# Connect subnet to route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}