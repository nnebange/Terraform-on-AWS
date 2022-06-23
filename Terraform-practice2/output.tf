# Outputs
output "public_ip_address" {
  value = aws_instance. Amazon_linux2_instance.public_ip
}

output "server_public_dns" {
  value = aws_instance. Amazon_linux2_instance.public_dns
}
