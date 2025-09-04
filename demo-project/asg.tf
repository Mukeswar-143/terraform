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
  name                 = "web-server-asg"
  vpc_zone_identifier  = aws_subnet.private[*].id
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  health_check_type    = "ELB"
  target_group_arns    = [aws_lb_target_group.main.arn]
  termination_policies = ["ClosestToNextInstanceHour", "OldestLaunchConfiguration", "Default"]

  launch_template {
    id      = aws_launch_template.web_server.id
    version = "$Latest"
  }
}
