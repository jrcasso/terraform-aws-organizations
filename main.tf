terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "terraform-organizations"
    key    = "mean-demo/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "personal"
  region  = "us-east-1"
}

data "terraform_remote_state" "organizations" {
  backend = "s3"
  config = {
    bucket = "terraform-organizations"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_route53_zone" "organization" {
  name = var.domain

  tags = {
    org = var.domain
  }
}

resource "aws_route53_record" "organization_ssl_cert" {
  zone_id = aws_route53_zone.organization.zone_id
  name    = var.dns_ssl_record_name
  type    = "CNAME"
  ttl     = "60"
  records = [var.dns_ssl_record_value]
}

data "aws_acm_certificate" "amazon_issued" {
  domain      = var.domain
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
