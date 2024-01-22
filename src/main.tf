provider "aws" {
 # region = var.region  # Change this to your desired AWS region
 # access_key = var.access_key
 # secret_key = var.secret-key
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
