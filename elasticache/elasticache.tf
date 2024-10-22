
resource "aws_elasticache_cluster" "my_redis" {
  cluster_id           = "my-redis-cluster"
  engine              = "redis"
  node_type           = "cache.t3.micro"
  num_cache_nodes     = 1
  subnet_group_name   = aws_elasticache_subnet_group.my_redis_subnet_group.name
  security_group_ids  = [aws_security_group.redis_sg.id]

  tags = {
    Name = "MyRedisCluster"
  }
}

resource "aws_elasticache_subnet_group" "my_redis_subnet_group" {
  name       = "my-redis-subnet-group"
  subnet_ids = [var.private_subnet_id_1, var.private_subnet_id_2]

  tags = {
    Name = "MyRedisSubnetGroup"
  }
}

resource "aws_security_group" "redis_sg" {
  name        = "redis_sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Adjust to your VPC CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Redis-SG"
  }
  }
