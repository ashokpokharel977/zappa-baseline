##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["*private*"]
  }
}


#####
# SG
#####
resource "aws_security_group" "rds_sg" {
  name        = "rds_private_sg"
  description = "Allow inbound traffic from private subnets"
  vpc_id      = var.vpc_id

  ingress {
    description = "MYSQL Ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
# data "aws_secretsmanager_secret_version" "creds" {
#   # Fill in the name you gave to your secret
#   secret_id = "db-creds"
# }
# locals {
#   db_creds = jsondecode(
#     data.aws_secretsmanager_secret_version.creds.secret_string
#   )
# }
#   # Set the secrets from AWS Secrets Manager
#   username = local.db_creds.username
#   password = local.db_creds.password
#####
# DB
#####
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = var.db_name

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = var.db_instance_size
  storage_encrypted = true
  allocated_storage = var.db_instance_disk_size

  # kms_key_id        = "arm:aws:kms:<region>:<accound id>:key/<kms key id>"
  name     = var.db_name
  username = var.db_user_name
  password = var.db_password
  port     = "3306"

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  multi_az = true

  # disable backups to create DB faster
  backup_retention_period = 0

  tags = {
    Terraform   = "true"
    Environment = var.env
    Product     = var.product_name
  }

  enabled_cloudwatch_logs_exports = ["audit", "general"]

  # DB subnet group
  subnet_ids = data.aws_subnet_ids.private.ids

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "${var.db_name}-snapshot"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8"
    },
    {
      name  = "character_set_server"
      value = "utf8"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}
