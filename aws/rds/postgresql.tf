resource "aws_db_instance" "app_db" {
  identifier           = "${var.app_name}-db"

  engine               = "postgres"
  engine_version       = "11.5"

  allocated_storage    = 20
  storage_type         = "gp2"
  instance_class       = var.app_env == "production" ? "db.t5.large" : "db.t3.micro"

  name                 = "postgres"
  username             = "postgres"
  password             = "postgres"
  port                 = "5432"

  multi_az             = var.app_env == "production" ? true : false
  performance_insights_enabled = true
  deletion_protection  = var.app_env == "production" ? true : false

  parameter_group_name = aws_db_parameter_group.app_db.name

  vpc_security_group_ids = ["${aws_security_group.rds_app_db.id}"]

  db_subnet_group_name = "default"
  backup_retention_period = 7
  auto_minor_version_upgrade = false
  monitoring_interval = 60
  monitoring_role_arn = data.aws_iam_role.rds_monitoring_role.arn
  skip_final_snapshot = true

  tags = {
    CmBillingGroup = var.app_name}-${var.app_env
  }
}

data "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"
}

resource "aws_db_parameter_group" "app_db" {
  name   = "${var.app_name}-pg"
  family = "postgres11"
}

resource "aws_security_group" "rds_app_db" {
  name   = "rds-app-db"
  vpc_id = data.aws_vpc.local.id
}

resource "aws_security_group_rule" "allow_postgres_vpc" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = [data.aws_vpc.local.cidr_block]
  security_group_id = aws_security_group.rds_app_db.id
}
