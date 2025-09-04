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
