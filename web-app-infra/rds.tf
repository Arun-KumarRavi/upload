# DB subnet group

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private_db_az_1.id, aws_subnet.private_db_az_2.id]

  tags = {
    Name = "DB Subnet Group"
  }
}

# RDS mysql instance

resource "aws_db_instance" "mysql_instance" {
  identifier        = "mysql-instance"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "mydb"
  username = "admin"
  password = var.db_password

  multi_az            = true
  publicly_accessible = false

  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  backup_retention_period = 7
  deletion_protection     = true

  skip_final_snapshot       = false
  final_snapshot_identifier = "mysql-final-snapshot"

  tags = {
    Name        = "MySQL-Instance"
    backup      = "true"
    Environment = "deployment"
    terraform   = "true"
  }
}