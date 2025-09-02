provider "aws" {
  region = "eu-north-1" # change to your AWS region
}

# Variables for reuse
variable "vpc_id" {
  default = "vpc-0ba4d0537bf92c9aa"
}

variable "public_subnets" {
  default = [
      "subnet-080978ab8dd41fa47",
      "subnet-0fae016d3ba84993c"
  ]
}

variable "key_name" {
  default = "devops" # <-- Replace with your AWS key pair
}

# Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg"
  }
}

# EC2 Instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-0c4fc5dcabc9df21d" 
  instance_type = "t3.micro"
  subnet_id     = element(var.public_subnets, 0) # pick first public subnet
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "My-EC2-Instance"
  }
}
