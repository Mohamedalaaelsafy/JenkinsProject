terraform {
  backend "s3" {
    bucket = "terraform-state-workspace"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}