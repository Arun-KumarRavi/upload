# AWS Backup Configuration for Database and EBS Volumes
# ─────────────────────────────────────────────────────────────────────────────

# 1. AWS Backup Vault
resource "aws_backup_vault" "main" {
  name        = "project-backup-vault"
  kms_key_arn = null # Defaults to the default KMS key for AWS Backup in the region

  tags = {
    Name        = "project-backup-vault"
    Environment = "deployment"
    terraform   = "true"
  }
}

# 2. AWS Backup Plan
resource "aws_backup_plan" "main" {
  name = "project-backup-plan"

  rule {
    rule_name         = "daily-backup-rule"
    target_vault_name = aws_backup_vault.main.name
    schedule          = "cron(0 12 * * ? *)" # Every day at 12:00 PM UTC

    lifecycle {
      delete_after = 30 # Retain backups for 30 days
    }
  }

  tags = {
    Name        = "project-backup-plan"
    Environment = "deployment"
    terraform   = "true"
  }
}

# 3. IAM Role for AWS Backup
resource "aws_iam_role" "aws_backup_role" {
  name = "aws-backup-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "aws-backup-service-role"
    Environment = "deployment"
    terraform   = "true"
  }
}

# Attach AWS Backup Policies to the IAM Role
resource "aws_iam_role_policy_attachment" "backup_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.aws_backup_role.name
}

resource "aws_iam_role_policy_attachment" "restore_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  role       = aws_iam_role.aws_backup_role.name
}

# 4. AWS Backup Selection
resource "aws_backup_selection" "main" {
  iam_role_arn = aws_iam_role.aws_backup_role.arn
  name         = "project-backup-selection"
  plan_id      = aws_backup_plan.main.id

  # Explicit Resource ARNs
  resources = [
    aws_db_instance.mysql_instance.arn,
    aws_instance.jenkins_server.arn
  ]

  # Dynamic Tag-based Selection (e.g. for future Prometheus/Grafana EBS volumes)
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "backup"
    value = "true"
  }
}
