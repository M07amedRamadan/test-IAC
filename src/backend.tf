terraform {
  backend "s3" {
    bucket = "terraform.tfstate-bucket"
    region = "us-west-2"
    key = "keyname"

  }
}
