provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    key    = "terraform-backend/"
    bucket = "site-tf-state"
    region = "us-east-1"
  }
}
