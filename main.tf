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

variable "instance_type" {
    type = string
}

resource "aws_instance" "app_server" {
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = var.instance_type

  tags = {
    Name = "MyTerraformServer"
  }
}