provider "aws" {
  region = "us-east-1"
  
}
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name = "private-route-table"
  }
}
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id = aws_subnet.public_subnet.id
  allocation_id = aws_eip.eip.id
  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_eip" "eip" {      
  domain = "vpc"
}


resource "aws_security_group" "private_security_group" {
  vpc_id = aws_vpc.my_vpc.id
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "private-security-group"
  }
}

resource "aws_instance" "private_machine" {
  ami = var.ami
  key_name = var.key_name
  instance_type = var.instance_type
  subnet_id = aws_subnet.private_subnet.id
  vpc_security_group_ids  = [aws_security_group.private_security_group.id]
  tags = {
    Name = "private-machine"
  }
  
}
