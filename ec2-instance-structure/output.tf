output "EC2_public_ip" {
  value = aws_instance.linux_VM.public_ip
}
output "EC2_private_ip" {
  value = aws_instance.linux_VM.private_ip
}