output "db_instance_address" {
  value = "${module.db.this_db_instance_address}"
}

output "db_instance_endpoint" {
  value = "${module.db.this_db_instance_endpoint}"
}
