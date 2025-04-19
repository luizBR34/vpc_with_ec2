#Create AWS VPC
resource "aws_vpc" "levelup_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "levelup_vpc"
  }
}

resource "aws_subnet" "levelup_vpc_public" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"

  tags = {
    Name = "levelup_vpc_public"
  }
}

# Custom internet Gateway
resource "aws_internet_gateway" "levelup-gw" {
  vpc_id = aws_vpc.levelup_vpc.id

  tags = {
    Name = "levelup-gw"
  }
}

#Routing Table for the Custom VPC
resource "aws_route_table" "levelup-public" {
  vpc_id = aws_vpc.levelup_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.levelup-gw.id
  }
}

resource "aws_route_table_association" "levelup-public" {
  subnet_id      = aws_subnet.levelup_vpc_public.id
  route_table_id = aws_route_table.levelup-public.id
}
