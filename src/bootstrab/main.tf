provider "aws" {
  region = "us-west-2"  
}

resource "aws_s3_bucket" "statebucket" {
  bucket = "terraform.tfstate-bucket-ramadan"

  tags = {
   # Name        = "My bucket"
    Environment = "Dev"
  }
}
