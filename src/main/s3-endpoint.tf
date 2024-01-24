resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id      = aws_vpc.Main-VPC.id
  service_name = "com.amazonaws.us-west-2.s3"  # Adjust the region
}

resource "aws_route_table_association" "s3_endpoint_association" {
  subnet_id      = aws_subnet.private_subnet.id  # Replace with your private subnet ID
  route_table_id = aws_vpc.Main-VPC.main_route_table_id # Replace with your route table ID
}

output "s3_bucket_endpoint" {
  value = aws_vpc_endpoint.s3_endpoint.dns_entry
}