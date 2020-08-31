terraform {
  required_version = "= 0.13.0"
}

variable "region" {
  default = "us-east-2"
}

provider "aws" {
  region                  = var.region
  version                 = "~> 3.0.0"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "nific"
}

resource "aws_s3_bucket" "terraform-state-dev" {
  bucket = "mirailifecare-terraform-remote-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "mirailifecare-terraform-remote-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }
}
