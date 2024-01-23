
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
          Service = "ssm.amazonaws.com"
        },
      },
    ],
  })
}

# IAM Policy
resource "aws_iam_policy" "ssm_console_access_policy" {
  name        = "ssm-console-access-policy"
  description = "IAM policy for SSM console access to EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:StartSession",
          "ssm:TerminateSession",
          "ssm:ResumeSession",
          "ssm:ListSessions",
          "ssm:DescribeSessions",
        ],
        Resource = "*",
      },
    ],
  })
}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "example_attachment" {
  policy_arn = aws_iam_policy.ssm_connection_policy.arn
  role       = aws_iam_role.example_role.name
}
