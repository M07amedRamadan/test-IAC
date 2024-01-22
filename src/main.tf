provider "aws" {
  region = "us-west-1"  # Change this to your desired AWS region
}

# Define the first VPC
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Main-VPC"
  }
}
