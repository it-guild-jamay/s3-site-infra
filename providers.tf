provider "aws" {
  region  = var.aws_region
}

terraform {
  backend "s3" {
    key    = "terraform-backend/"
    bucket = "site-tf-state"
    region = "us-east-1"
  }
}
