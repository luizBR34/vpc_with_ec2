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


#Public Subnet in Custom VPC
resource "aws_subnet" "levelup_vpc_public_1" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"

  tags = {
    Name = "levelup_vpc_public_1"
  }
}

resource "aws_subnet" "levelup_vpc_public_2" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"

  tags = {
    Name = "levelup_vpc_public_2"
  }
}

resource "aws_subnet" "levelup_vpc_public_3" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2c"

  tags = {
    Name = "levelup_vpc_public_3"
  }
}


#Private Subnet in Custom VPC
resource "aws_subnet" "levelup_vpc_private_1" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2a"

  tags = {
    Name = "levelup_vpc_private_1"
  }
}

resource "aws_subnet" "levelup_vpc_private_2" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2b"

  tags = {
    Name = "levelup_vpc_private_2"
  }
}

resource "aws_subnet" "levelup_vpc_private_3" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2c"

  tags = {
    Name = "levelup_vpc_private_3"
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

  tags = {
    Name = "levelup-public-1"
  }
}

resource "aws_route_table_association" "levelup-public-1-a" {
  subnet_id      = aws_subnet.levelup_vpc_public_1.id
  route_table_id = aws_route_table.levelup-public.id
}

resource "aws_route_table_association" "levelup-public-2-a" {
  subnet_id      = aws_subnet.levelup_vpc_public_2.id
  route_table_id = aws_route_table.levelup-public.id
}

resource "aws_route_table_association" "levelup-public-3-a" {
  subnet_id      = aws_subnet.levelup_vpc_public_3.id
  route_table_id = aws_route_table.levelup-public.id
}