

# Define your MongoDB Atlas VPC CIDR block
# This should be retrieved from your MongoDB Atlas account
variable "mongodb_atlas_cidr" {
  default = "192.168.248.0/21"  # Replace with your MongoDB Atlas CIDR block
}

# Create VPC peering connection
resource "aws_vpc_peering_connection" "my_peering_connection" {
  peer_vpc_id          = "vpc-0c2f60a694a109ae5"  # Replace with your MongoDB Atlas VPC ID
  vpc_id               = aws_vpc.Main-VPC.id
  auto_accept          = true
  #peer_owner_id        = "mongodb_atlas_account_id"
  peer_region          = "us-east-1"  # Replace with your MongoDB Atlas region

  tags = {
    Name = "MyVPCPeeringConnection-MongoDB"
  }
}

# Update route tables in your AWS VPC
resource "aws_route" "my_route" {
  route_table_id         = aws_vpc.Main-VPC.main_route_table_id  # Replace with your AWS route table ID
  destination_cidr_block = var.mongodb_atlas_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.my_peering_connection.id
}

# Add MongoDB Atlas CIDR block to security group rules
resource "aws_security_group" "mongodb_security_group" {
  name        = "mongodb_security_group"
  description = "Security group for MongoDB Atlas"
  vpc_id      = aws_vpc.Main-VPC.id
#this is the input rule which is accept connection from port 27017 to port 27017 from the mongodb cidr_block
  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"
    cidr_blocks = [var.mongodb_atlas_cidr]
  }
#this is the output rule which is accept all connections from and to any port to the mongodb cidr_block
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [var.mongodb_atlas_cidr]
  }
}
