terraform {
  backend "s3" {
    bucket = "terraform.statetf-bucket"
    region = "us-west-2"
    key = "keyname"

  }
}
