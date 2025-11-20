
# Enables additional RDS features

resource "aws_db_option_group" "example" {
  name                     = "sqlserver-option-group"
  option_group_description = "SQL Server Option Group"
  engine_name              = "sqlserver-se"
  major_engine_version     = "15.00"
  option {
    option_name = "SQLSERVER_BACKUP_RESTORE"
    option_settings {
      name  = "IAM_ROLE_ARN"
      value = aws_iam_role.backup_role.arn
    }
  }
}
