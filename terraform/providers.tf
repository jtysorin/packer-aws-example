terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "jtysorin"
    workspaces {
      name = "myapp-workspace"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}