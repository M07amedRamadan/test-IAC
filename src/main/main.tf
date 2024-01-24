provider "aws" {
  alias = "main"
 region = var.region  # Change this to your desired AWS region
}


# Define the first VPC
resource "aws_vpc" "Main-VPC" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Main-VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.Main-VPC.id
  cidr_block              = "11.0.1.0/24"  # Adjust CIDR block as needed
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet Ramadan"
  }
} 

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.Main-VPC.id
  cidr_block              = "11.0.1.0/24"  # Adjust CIDR block as needed

  tags = {
    Name = "Private Subnet Ramadan"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "Mygateway" {
  vpc_id = aws_vpc.Main-VPC.id
}

# Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.Main-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Mygateway.id
  }
}

# Associating Public Subnet with the Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create a security group
resource "aws_security_group" "example_security_group" {
  vpc_id = aws_vpc.Main-VPC.id
  name        = "security-group"
  description = "Security Group for EC2 instances"
#this is the input rule which is accept all connections from and to any port from the internet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
#this is the output rule which is accept all connections from and to any port to the internet

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
