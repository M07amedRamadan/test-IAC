resource "aws_instance" "Instance1" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.example_security_group.id]
  subnet_id              = aws_subnet.public_subnet.id
  iam_instance_profile   =  aws_iam_instance_profile.instance_profile.name
  key_name               = "bakry" #key_pairs already exist
  tags = {
    Name = "${var.CUSTOMER_NAME}-ec1"
  }
}


resource "aws_instance" "Instance2" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.example_security_group.id]
  subnet_id              = aws_subnet.public_subnet.id
  iam_instance_profile   =  aws_iam_instance_profile.instance_profile.name
  key_name               = "bakry" #key_pairs already exist


  tags = {
    Name = "${var.CUSTOMER_NAME}-ec2"
  }
 
}

