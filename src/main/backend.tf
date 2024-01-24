
terraform {
  backend "s3" {
    bucket = "terraform.tfstate-bucket-ramadan"
    region = var.region
    key    = "keyname/terraform.tfstate"
  }
}
