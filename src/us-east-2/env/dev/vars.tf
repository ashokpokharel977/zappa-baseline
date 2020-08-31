variable "region" {
  type        = string
  description = "AWS Region used"
  default     = "us-east-2"
}
variable "env" {
  type    = string
  default = "dev"
}
variable "product_name" {
  type    = string
  default = "dev"
}
variable "vpc_id" {
  type = string
}

variable "db_name" {
  type    = string
  default = "mirailifecaredb"
}
variable "db_user_name" {
  type    = string
  default = "mirailifecaredbuser"
}
variable "db_password" {
  type    = string
  default = "!YourPwd#Should$BeLong%And^Secure"
}
variable "db_instance_size" {
  type    = string
  default = "db.t2.large"
}
variable "db_instance_disk_size" {
  type    = number
  default = 50
}
