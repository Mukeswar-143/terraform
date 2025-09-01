provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "linux-VM" {
  ami             = "ami-0c4fc5dcabc9df21d"
  instance_type   = "t3.micro"
  key_name        = "devops"
  security_groups = ["default"]
  tags = {
    Name = "Terraform_EC2_Instance"
  }
}