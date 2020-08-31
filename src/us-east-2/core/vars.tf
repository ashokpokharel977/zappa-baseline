variable "env" {
  type    = string
  default = "dev"
}
variable "product_name" {
  type    = string
  default = "dev"
}
variable "vpc_name" {
  type    = string
  default = "test-vpc"
}
variable "cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}
variable "enable_nat_gateway" {
  type    = bool
  default = true
}
variable "enable_vpn_gateway" {
  type    = bool
  default = false
}
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}
variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "public_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
