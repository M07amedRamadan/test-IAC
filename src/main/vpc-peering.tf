
 # Create a VPC peering connection
 resource "aws_vpc_peering_connection" "peering_connection" {
   peer_region = "us-west-1"
   peer_vpc_id = "vpc-0528c65dcd5e11cee"
   vpc_id      = aws_vpc.Main-VPC.id

   #auto_accept = true
   
   tags = {
     Name = "VPC-Peering"
   }
 }

 # Create a route in the first VPC's route table to the second VPC via the peering connection
 resource "aws_route" "route_to_vpc2" {
   route_table_id         = aws_vpc.vpc1.main_route_table_id
   destination_cidr_block = "172.31.0.0/16"
   vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
 }
#  # Create a route in the second VPC's route table to the first VPC via the peering connection
#  resource "aws_route" "route_to_vpc1" {
#    route_table_id         = aws_vpc.vpc2.main_route_table_id
#    destination_cidr_block = aws_vpc.vpc1.cidr_block
#    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
#  }
