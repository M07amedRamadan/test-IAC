
data "aws_iam_role" "existing_role" {
  name = "bakryCloudWatch"  # Replace with the name of your existing IAM role
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "instance-profile"

  role = data.aws_iam_role.existing_role.name
}