
data "aws_iam_role" "existing_role" {
  name = "your_existing_role_name"  # Replace with the name of your existing IAM role
}

resource "aws_iam_instance_profile" "example_instance_profile" {
  name = "example-instance-profile"

  role = data.aws_iam_role.existing_role.name
}