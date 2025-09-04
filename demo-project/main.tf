# AWS Provider Configuration
provider "aws" {
  region = "eu-north-1"  # Change to your desired AWS region
}
# Variables.
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "instance_type" {
  description = "The EC2 instance type for the web servers"
  type        = string
  default     = "t3.micro"
}

# VPC and Subnets
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "production-vpc"
  }
}

# Retrieve a list of availability zones for the specified region.
data "aws_availability_zones" "available" {
  state = "available"
}

# Create public subnets in different availability zones.
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

# Create private subnets in different availability zones.
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

# Internet Gateway and Public Routes
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

# Create a route table for the public subnets.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate the public route table with the public subnets.
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# NAT Gateways and Private Routes
resource "aws_eip" "nat" {
  count = length(aws_subnet.public)
  domain = "vpc"
}

# Create NAT Gateways in each public subnet.
resource "aws_nat_gateway" "main" {
  count         = length(aws_subnet.public)
  subnet_id     = aws_subnet.public[count.index].id
  allocation_id = aws_eip.nat[count.index].id

  tags = {
    Name = "nat-gateway-${count.index + 1}"
  }
}

# Create a separate route table for each private subnet to direct traffic through its respective NAT Gateway.
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "private-route-table-${count.index + 1}"
  }
}

# Associate the private route tables with the private subnets.
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# Security Groups
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow all inbound HTTP/HTTPS traffic"
  vpc_id      = aws_vpc.main.id

  # Inbound rule for HTTP.
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound rule for HTTPS (recommended for production).
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

# Create a Security Group for the EC2 instances.
resource "aws_security_group" "instance_sg" {
  name        = "instance-sg"
  description = "Allow inbound traffic from ALB"
  vpc_id      = aws_vpc.main.id

  # Inbound rule to allow HTTP traffic only from the ALB security group.
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "instance-sg"
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = "production-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Name = "production-alb"
  }
}

# Create a target group for the Application Load Balancer.
resource "aws_lb_target_group" "main" {
  name        = "production-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  # Corrected health check settings for better reliability during instance startup.
  # This gives the EC2 instances more time to become healthy and avoids the 502 error.
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 30
    interval            = 60
  }

  tags = {
    Name = "production-tg"
  }
}

# Create an ALB listener that forwards HTTP traffic to the target group.
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

# Launch Template and Auto Scaling Group
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Define the user data script to install a web server on the instances.
# This script will run on the first boot of each EC2 instance.
locals {
  user_data = <<-EOT
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo echo "<h1>Hello from a web server in a private subnet!</h1>" > /var/www/html/index.html
  EOT
}

# Create a launch template for the EC2 instances.
resource "aws_launch_template" "web_server" {
  name_prefix   = "web-server-"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.instance_sg.id]
  }

  user_data = base64encode(local.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-server"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create an Auto Scaling Group to manage the EC2 instances.
resource "aws_autoscaling_group" "main" {
  name                      = "web-server-asg"
  vpc_zone_identifier       = aws_subnet.private[*].id
  desired_capacity          = 2
  max_size                  = 4
  min_size                  = 2
  health_check_type         = "ELB"
  target_group_arns         = [aws_lb_target_group.main.arn]
  termination_policies      = ["ClosestToNextInstanceHour", "OldestLaunchConfiguration", "Default"]

  launch_template {
    id      = aws_launch_template.web_server.id
    # Corrected the version from "$$Latest" to "$Latest"
    version = "$Latest"
  }
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}
