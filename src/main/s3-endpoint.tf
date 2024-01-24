resource "aws_vpc_endpoint" "s3_endpoint" {
    vpc_id      = aws_vpc.Main-VPC.id
    service_name = "com.amazonaws.us-west-2.s3"  # Adjust the region
    security_group_ids = [aws_security_group.example_security_group.id]

    tags = {Name = "s3_endpoint"}

}




output "s3_bucket_endpoint" {
  value = aws_vpc_endpoint.s3_endpoint.vpc_endpoint_type
}