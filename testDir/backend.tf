terraform {
  backend "s3" {    
    bucket         = "terraform.tfstate-bucket-ramadan"
    region         = "us-east-1"
    key = "terraform.tfstate" 
}
}
