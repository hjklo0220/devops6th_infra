output "db_public_ip" {
  value = module.db-server.public_ip
}

output "be_public_ip" {
  value = module.be-server.public_ip
}

output "lb_dns" {
  value = module.lb.lb_dns
}
