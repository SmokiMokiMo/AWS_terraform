resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  vpc_id      = var.vpc_id
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_ip]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-SG"
  }
}

resource "aws_instance" "my_ec2_instance_1" {
  ami                    = "ami-0084a47cc718c111a"  
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id_1  # Use first public subnet
  security_groups        = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name  

  tags = {
    Name = "MyEC2Instance1"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              EOF
}

resource "aws_instance" "my_ec2_instance_2" {
  ami                    = "ami-0084a47cc718c111a"  
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id_2  # Use second public subnet
  security_groups        = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name  

  tags = {
    Name = "MyEC2Instance2"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              EOF
}

# Optional: Application Load Balancer
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = [var.public_subnet_id_1, var.public_subnet_id_2]  # Reference both public subnets
  enable_deletion_protection = false

  tags = {
    Name = "MyALB"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "my_target_attachment_1" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.my_ec2_instance_1.id  # Attach first EC2 instance
  port             = 80
}

resource "aws_lb_target_group_attachment" "my_target_attachment_2" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.my_ec2_instance_2.id  # Attach second EC2 instance
  port             = 80
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}
