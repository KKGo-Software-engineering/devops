terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.29.0"
    }
  }
  cloud {
    organization = "AorJoa-DevOps-Training"

    workspaces {
      name = "devops-infra"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}