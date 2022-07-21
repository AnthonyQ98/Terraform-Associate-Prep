terraform {
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "anthony-test"

        workspaces {
          name = "getting-started"
        }
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.22.0"
    }
  }
}

locals {
    project_name = "Anthony"
}