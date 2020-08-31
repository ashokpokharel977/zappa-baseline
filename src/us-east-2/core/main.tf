variable "region" {
  default = "us-east-2"
}
provider "aws" {
  region                  = var.region
  version                 = "~> 3.0.0"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "nific"
}


terraform {
  required_version = "= 0.13.0"
  backend "s3" {
    profile        = "nific"
    bucket         = "mirailifecare-terraform-remote-state"
    region         = "us-east-2"
    key            = "core.tfstate"
    dynamodb_table = "mirailifecare-terraform-remote-state-lock"
  }
}

module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "2.48.0"
  name                   = var.vpc_name
  cidr                   = var.cidr_range
  azs                    = var.availability_zones
  private_subnets        = var.private_subnets
  public_subnets         = var.public_subnets
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_s3_endpoint     = true
  enable_nat_gateway     = var.enable_nat_gateway
  enable_vpn_gateway     = var.enable_vpn_gateway

  tags = {
    Terraform   = "true"
    Environment = var.env
    Product     = var.product_name

  }

}
