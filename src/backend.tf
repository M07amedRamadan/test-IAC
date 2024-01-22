terraform {
  backend "s3" {
    region = "us-west-2"
    bucket = "terraform.tfstate-bucket-ramadan"

  }
}
