provider "aws" {
  region = "us-west-1"  # Change this to your desired AWS region
}

# Define the first VPC
resource "aws_vpc" "Main-VPC"" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Main-VPC"
  }
}
