resource "aws_instance" "Instance1" {
  ami           = var.ami
  instance_type = var.instance_type
  #key_name               = "vultara-report-server-KP"
  vpc_security_group_ids = [aws_security_group.example_security_group.id]
  subnet_id              = aws_subnet.public_subnet.id
  iam_instance_profile   =  aws_iam_instance_profile.instance_profile.name
  tags = {
    Name = "${var.CUSTOMER_NAME}-ec1"
  }
}


resource "aws_instance" "Instance2" {
  ami           = var.ami
  instance_type = var.instance_type
  #key_name               = "vultara-trial-scheduler-KP"
  vpc_security_group_ids = [aws_security_group.example_security_group.id]
  subnet_id              = aws_subnet.public_subnet.id
  iam_instance_profile   =  aws_iam_instance_profile.instance_profile.name

  tags = {
    Name = "${var.CUSTOMER_NAME}-ec2"
  }
 
}

# IAM Instance Profile
# Used to attach iam-role with ec2 
resource "aws_iam_instance_profile" "instance_profile" {
  name = "Instance-profile"
  role = aws_iam_role.example_role.name 
}
