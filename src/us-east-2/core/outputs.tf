output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
output "vpc_cidr" {
  value = "${module.vpc.vpc_cidr_block}"
}
output "nat_public_ips" {
  value = "${module.vpc.nat_public_ips}"
}
