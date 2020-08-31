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

variable "secret_name" {
  type    = string
  default = "dbsecret"
}

variable "example" {
  default = {
    username = "mirailifecaredbuser"
    password = "!YourPwd#Should$BeLong%And^Secure"
  }

  type = map(string)
}
