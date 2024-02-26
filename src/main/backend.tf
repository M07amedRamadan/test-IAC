terraform {
  backend "s3" {
    bucket = "terraform.tfstate-bucket-ramadan"
    region = "us-west-2"
    key    = "keyname/terraform.tfstate"
  }
}
