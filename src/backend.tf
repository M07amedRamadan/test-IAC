terraform {
  backend "s3" {
    bucket = "terraform.state-bucket"
    region = us-west-2
  }
}
