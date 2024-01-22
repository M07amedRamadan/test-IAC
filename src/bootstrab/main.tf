provider "aws" {
  region = "us-west-2"  
}


data "aws_s3_bucket" "existing_bucket" {
  bucket = "terraform.tfstate-bucket-ramadan"
}

resource "aws_s3_bucket" "statebucket" {
count = data.aws_s3_bucket.existing_bucket != null ? 0 : 1 # If the bucket exists, don't create it
  bucket = "terraform.tfstate-bucket-ramadan"
}

output "bucket_message" {
  value = data.aws_s3_bucket.existing_bucket != null ? "Bucket already exists!" : "Bucket created successfully!"
}
