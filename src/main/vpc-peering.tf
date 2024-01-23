#peer region to be used at accepter resource.
provider "aws" {
  alias  = "peer"
  region = "us-west-1"

  # Accepter's credentials.
}
 
 # Create a VPC peering connection
  resource "aws_vpc_peering_connection" "peering_connection" {
   peer_region = "us-west-1"
   peer_vpc_id = "vpc-0528c65dcd5e11cee"
   vpc_id      = aws_vpc.Main-VPC.id
   
   tags = {
     Name = "VPC-Peering"
     Side = "Requester"
   }
 }

 resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}


 # Create a route in the first VPC's route table to the second VPC via the peering connection
 resource "aws_route" "route_to_vpc2" {
   route_table_id         = aws_vpc.Main-VPC.default_route_table_id
   destination_cidr_block = "172.31.0.0/16" # the cidr_block of the peering vpc
   vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
 }

#  resource "aws_route" "route_to_vpc1" {
#    route_table_id         = data.aws_route_table.default_route_table.id
#    destination_cidr_block = "172.31.0.0/16" # the cidr_block of the peering vpc
#    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
#  }
 

data "aws_vpc" "example" {
  provider = aws.peer
  id = "vpc-0528c65dcd5e11cee"  # Replace with the ID of your VPC
}

# data "aws_route_table" "default_route_table" {
#   vpc_id = data.aws_vpc.example.cidr_block
# }

# output "default_route_table_id" {
#   value = data.aws_route_table.default_route_table.id
# }

output "vpc_cidr_block" {
  value = data.aws_vpc.example.cidr_block
}

output "main_route_table_id" {
  value = data.aws_vpc.example.main_route_table_id
}
