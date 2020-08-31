resource "aws_secretsmanager_secret" "db_secret" {
  name = var.secret_name
  tags = {
    Terraform   = "true"
    Environment = var.env
    Product     = var.product_name
  }
}

