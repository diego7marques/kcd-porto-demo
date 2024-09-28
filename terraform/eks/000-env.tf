terraform {
  backend "s3" {
    bucket = "k8gb-kcdporto-tf"
    key    = "terraformstate/aws-bkp.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.69.0"
    }
  }
}