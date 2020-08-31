provider "aws" {
  version                 = "~> 3.0"
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "nific"
}


terraform {
  required_version = "= 0.13.0"
  backend "s3" {
    profile        = "nific"
    bucket         = "mirailifecare-terraform-remote-state"
    region         = "us-east-2"
    key            = "dev.tfstate"
    dynamodb_table = "mirailifecare-terraform-remote-state-lock"
  }
}
module "rds" {
  source                = "./../../../../_modules/rds"
  env                   = var.env
  region                = var.region
  product_name          = var.product_name
  vpc_id                = var.vpc_id
  db_name               = var.db_name
  db_user_name          = var.db_user_name
  db_password           = var.db_password
  db_instance_size      = var.db_instance_size
  db_instance_disk_size = var.db_instance_disk_size
}
