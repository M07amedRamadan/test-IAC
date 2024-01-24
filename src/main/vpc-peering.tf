#peer region to be used at accepter resource.
provider "aws" {
  alias  = "peer"
  region = "us-west-1"

  # Accepter's credentials if in another account.
}
 
 # Create a VPC peering connection
  resource "aws_vpc_peering_connection" "peering_connection" {
   peer_region = "us-west-1" #the region of the vpc we need to peer with if it in another vpc
   peer_vpc_id = "vpc-0fd5c529a45ac6978"
   vpc_id      = aws_vpc.Main-VPC.id
   
   tags = {
     Name = "VPC-Peering"
     Side = "Requester"
   }
 }
#to auto accept as the vpc in another region
 resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer #provide the peer region
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}


 # Create a route in our VPC's route table to the  VPC via the peering connection
 resource "aws_route" "route_to_existance_vpc" {
   route_table_id         = aws_vpc.Main-VPC.main_route_table_id
   destination_cidr_block = data.aws_vpc.Existance_VPC.cidr_block # the cidr_block of the Existing VPC
   vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
 }

 # Create a route in the VPC's route table to the  our VPC via the peering connection
 resource "aws_route" "route_to_main_vpc" {
   provider               = aws.peer
   route_table_id         = data.aws_vpc.Existance_VPC.main_route_table_id
   destination_cidr_block = aws_vpc.Main-VPC.cidr_block # the cidr_block of Main VPC
   vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
 }
 
#Retreiving the Existing VPC data.
data "aws_vpc" "Existance_VPC" {
  provider = aws.peer
  id = "vpc-0fd5c529a45ac6978"  # Replace with the ID of your VPC
}
