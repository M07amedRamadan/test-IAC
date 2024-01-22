provider "aws" {
  region = "us-west-2"  
}

resource "aws_s3_bucket" "bootstrap" {
  bucket = "terraform.tfstate-bucket"
  acl    = "private"

}