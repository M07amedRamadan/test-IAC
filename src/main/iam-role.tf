
# IAM Role
resource "aws_iam_role" "example_role" {
  name = "example-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        #This action is used to establish trust relationships between different entities, allowing one entity to assume the permissions of the role.
        Action = "sts:AssumeRole", 
        Effect = "Allow",
        Principal = {
          Service = "ssm.amazonaws.com"  # Replace with the service principal you intend to grant access to
        },
      },
    ],
  })
}

# IAM Policy
resource "aws_iam_policy" "ssm_connection_policy" {
  name        = "ssm-connection-policy"
  description = "IAM policy for SSM connection"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:*",
        ],
        "Resource": "*"
      },
    ],
  })
}
# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "example_attachment" {
  policy_arn = aws_iam_policy.ssm_connection_policy.arn
  role       = aws_iam_role.example_role.name
}
