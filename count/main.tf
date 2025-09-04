# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

# Create 5 EC2 instances
resource "aws_instance" "my_instance" {
  count         = 5
  ami           = "ami-0c4fc5dcabc9df21d"
  instance_type = "t3.micro"

  tags = {
    Name = "MyInstance-${count.index}"
  }
}