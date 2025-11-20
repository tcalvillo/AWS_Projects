
# SQL Server databases,deployed in private subnets
# RDS Custom for SQL Server
# Lookup the available instance classes for the custom engine for the region being operated in

resource "aws_db_instance" "example" {
  allocated_storage      = 20
  engine                 = "sqlserver-se"
  engine_version         = "15.00.4249.2.v1"
  instance_class         = "db.t3.small"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name  # Reference the subnet group
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  storage_encrypted      = true
  publicly_accessible    = false
}



