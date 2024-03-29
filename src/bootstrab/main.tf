provider "aws" {
  region = var.region
}


data "aws_s3_bucket" "existing_bucket" {
  bucket = "terraform.tfstate-bucket-ramadan"
}
#check if there is an bucket with same name it will not create anothe one just use existance.
resource "aws_s3_bucket" "statebucket" {
count = data.aws_s3_bucket.existing_bucket != null ? 0 : 1 # If the bucket exists, don't create it
  bucket = "terraform.tfstate-bucket-ramadan"
}

output "bucket_message" {
  value = data.aws_s3_bucket.existing_bucket != null ? "Bucket already exists!" : "Bucket created successfully!"
}
