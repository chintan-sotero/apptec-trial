provider "aws" {
  region = var.region
}

resource "aws_db_subnet_group" "sotero" {
  name       = "sotero-trial-${var.customer_prefix}"
  subnet_ids = ["subnet-049b931e2eed54a3f", "subnet-0a787d0002b5dca62", "subnet-04a95789e07004351"]

  tags = {
    Name = "Sotero-trial-${var.customer_prefix}"
  }
}

resource "aws_security_group" "rds" {
  name   = "sotero_rds-${var.customer_prefix}"
  vpc_id = "vpc-0198587d8ca153e5c"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sotero_rds-${var.customer_prefix}"
  }
}

resource "aws_db_parameter_group" "sotero" {
  name   = "sotero-${var.customer_prefix}"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "random_password" "password" {
  length           = 8
  special          = true
  override_special = "_%@"
}

resource "aws_db_instance" "sotero_prod" {
  identifier             = "sotero-prod-${var.customer_prefix}"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = "soteroadmin"
  password               = random_password.password.result
  db_subnet_group_name   = aws_db_subnet_group.sotero.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.sotero.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

resource "aws_db_instance" "sotero_qa" {
  identifier             = "sotero-qa-${var.customer_prefix}"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = "soteroadmin"
  password               = random_password.password.result
  db_subnet_group_name   = aws_db_subnet_group.sotero.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.sotero.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
