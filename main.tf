terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "personal"
  region  = "us-east-1"
}

resource "aws_route53_zone" "organization" {
  name = var.domain

  tags = {
    organization = var.domain
  }
}
