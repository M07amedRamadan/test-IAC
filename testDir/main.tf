provider "aws" {
  region = "us-west-2"
}

#check if there is an bucket with same name it will not create anothe one just use existance.
resource "aws_s3_bucket" "statebucket" {
count = data.aws_s3_bucket.existing_bucket != null ? 0 : 1 # If the bucket exists, don't create it
  bucket = "terraform.tfstate-bucket-ramadan"
}

output "bucket_message" {
  value = data.aws_s3_bucket.existing_bucket != null ? "Bucket already exists!" : "Bucket created successfully!"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.CUSTOMER_NAME}.vultara.com"
  acl    = "private"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  
}

# Update the bucket policy
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  
  policy = <<EOF
    {
      "Version": "2008-10-17",
      "Id": "PolicyForCloudFrontPrivateContent",
      "Statement": [
        {
          "Sid": "1",
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ramadan}"
          },
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${var.CUSTOMER_NAME}.vultara.com/*"
        }
      ]
    }
  EOF

}
