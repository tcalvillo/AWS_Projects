
# Customizes database engine configurations

resource "aws_db_parameter_group" "example" {
  name   = "sqlserver-parameter-group"
  family = "sqlserver-se-15.00"
  parameter {
    name  = "timezone"
    value = "UTC"
  }
}
