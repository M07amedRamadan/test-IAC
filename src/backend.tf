terraform {
  backend "s3" {
    bucket = "terraform.state-bucket"
    region = var.region
  }
}
