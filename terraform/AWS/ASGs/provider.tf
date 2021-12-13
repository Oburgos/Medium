terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.65.0"
    }
  }
}

provider "aws" {
  region    = var.aws_info.region
  profile   = var.aws_info.profile
}


