# AWS Secrets Manager Secret for Database Credentials
# ─────────────────────────────────────────────────────────────────────────────

resource "aws_secretsmanager_secret" "db_credentials" {
  name                    = "mysql-db-credentials"
  description             = "Database connection credentials for RDS MySQL instance"
  recovery_window_in_days = 0 # Set to 0 for easier cleanups in dev environment

  tags = {
    Name        = "mysql-db-credentials"
    Environment = "deployment"
    terraform   = "true"
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = aws_db_instance.mysql_instance.username
    password = var.db_password
    host     = aws_db_instance.mysql_instance.address
    port     = aws_db_instance.mysql_instance.port
    database = aws_db_instance.mysql_instance.db_name
  })
}
