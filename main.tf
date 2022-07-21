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

variable "instance_type" {
    type = string
}

locals {
    project_name = "Anthony"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0cff7528ff583bf9a"
  instance_type = var.instance_type

  tags = {
    Name = "terraform-${local.project_name}"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  providers = {aws = aws.eu}
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

output "public_ip" {
    value = aws_instance.app_server.public_ip
}