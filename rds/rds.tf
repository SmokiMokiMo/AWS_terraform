resource "aws_db_instance" "my_db" {
  identifier              = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro" 
  allocated_storage       = 20
  username               = var.db_username
  password               = var.db_password
  db_name                = "mydatabase"
  skip_final_snapshot    = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
  multi_az               = false
  publicly_accessible     = false

  tags = {
    Name = "MyRDSInstance"
  }
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [var.private_subnet_id_1, var.private_subnet_id_2]

  tags = {
    Name = "MyDBSubnetGroup"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id 

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [var.ec2_sg_id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-SG"
  }
}
