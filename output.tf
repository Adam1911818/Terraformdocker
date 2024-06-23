# outputs.tf
output "instance_public_ip" {
  value = aws_instance.docker.public_ip
}
