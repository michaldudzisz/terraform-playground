output "ec2_public_ip" {
  value = module.app-server.instance.public_ip
}
