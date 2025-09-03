resource "aws_instance" "linux_VM" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = "devops"
  security_groups = ["default"]
  tags = {
    Name = "Terraform_VM"
  }
}