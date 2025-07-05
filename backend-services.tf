resource "aws_db_subnet_group" "vprofile-rds-subgrp" {
  name       = "vprofile-rds-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "subnet groups for rds"
  }

}

resource "aws_elasticache_subnet_group" "vprofile-elasticache-subgrp" {
  name       = "vprofile-elasticache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  tags = {
    Name = "subnet groups for elasticache"
  }

}

resource "aws_db_instance" "vprofile-rds" {
  identifier             = "vprofile-rds"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_subnet_group_name   = aws_db_subnet_group.vprofile-rds-subgrp.name
  vpc_security_group_ids = [aws_security_group.vprofile-backend-sg.id]
  db_name                = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  multi_az               = false
  skip_final_snapshot    = true
  publicly_accessible    = false

}

resource "aws_elasticache_cluster" "vprofile-cache" {
  cluster_id           = "vprofile-cache"
  engine               = "memcached" # Change to "redis" if you want to use Redis instead of Memcached port 6379
  engine_version       = "1.6.6"     # Use the appropriate version  # For Redis, use "6.x" or the latest version available
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.vprofile-elasticache-subgrp.name
  security_group_ids   = [aws_security_group.vprofile-backend-sg.id]
  parameter_group_name = "default.redis6.x"
  port                 = 11211 # For Redis, use 6379
  tags = {
    Name = "vprofile-elasticache"
  }
}

resource "aws_mq_broker" "vprofile-rmq" {
  broker_name             = "vprofile-rmq"
  engine_type             = "ActiveMQ"
  engine_version          = "5.15.14"
  host_instance_type      = "mq.t2.micro"
  publicly_accessible     = false
  security_groups         = [aws_security_group.vprofile-backend-sg.id]
  subnet_ids              = [module.vpc.private_subnets[0]]
  authentication_strategy = "SIMPLE"

  user {
    username = var.rmquser
    password = var.rmqpass
  }

  tags = {
    Name = "vprofile-mq-broker"
  }

}