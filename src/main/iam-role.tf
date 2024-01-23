
#Call Iam-role from AWS account to be reused.
data "aws_iam_role" "existing_role" {
  name = "bakryCloudWatch"  # Replace with the name of your existing IAM role
}

# IAM Instance Profile
# Used to attach iam-role with ec2 
resource "aws_iam_instance_profile" "instance_profile" {
  name = "Instance-profile"
  role = data.aws_iam_role.existing_role.name
}
