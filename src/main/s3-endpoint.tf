resource "aws_vpc_endpoint" "s3_endpoint" {
    vpc_id      = aws_vpc.Main-VPC.id
    service_name = "com.amazonaws.us-west-2.s3"  # Adjust the region

    tags = {Name = "s3_endpoint"}

}
resource "aws_vpc_endpoint_subnet_association" "s3_endpoint_association" {
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  subnet_id       = aws_subnet.private_subnet.id
}


resource "aws_vpc_endpoint_security_group_association" "name" {
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  security_group_id = aws_security_group.example_security_group.id
}