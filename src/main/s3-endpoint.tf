resource "aws_vpc_endpoint" "s3_endpoint" {
    vpc_id      = aws_vpc.Main-VPC.id
    service_name = "com.amazonaws.us-west-2.s3"  # Adjust the region

    tags = {Name = "s3_endpoint"}

}

resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_association" {
  vpc_endpoint_id =  aws_vpc_endpoint.s3_endpoint.id # Replace with your actual subnet ID
  route_table_id = aws_route_table.public_route_table.id # Replace with your actual route table ID
}



output "s3_bucket_endpoint" {
  value = aws_vpc_endpoint.s3_endpoint.vpc_endpoint_type
}