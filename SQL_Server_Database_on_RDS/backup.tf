# Automates RDS backups and maintenance, configure retention and window

resource "aws_backup_vault" "rds_backup_vault" {
  name = "rds-backup-vault"
}

resource "aws_backup_plan" "rds_backup_plan" {
  name = "rds-backup-plan"
  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.rds_backup_vault.name
    schedule          = "cron(0 12 * * ? *)"
    lifecycle {
      delete_after = 14
    }
  }
}

resource "aws_backup_selection" "rds_backup_selection" {
  name         = "rds-backup-selection"
  iam_role_arn = aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.rds_backup_plan.id
  resources    = [aws_db_instance.example.arn]
}

