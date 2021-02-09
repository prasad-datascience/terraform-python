terraform {
  backend "s3" {
    bucket = "dummy-newman"
    key    = "terraform/terraform.tfstate"
    region = "ap-south-1"
  }
}