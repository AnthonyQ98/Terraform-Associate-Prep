terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}


provider "aws" {
  region  = "eu-west-1"
  profile = "default"
  alias = "eu"
}