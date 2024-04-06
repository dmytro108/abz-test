resource "aws_db_instance" "mysql" {
  identifier        = "wp-db"
  instance_class    = "db.t3.micro"
  allocated_storage = 5
  engine            = "mysql"
  engine_version    = "8.0"

  multi_az             = true
  db_subnet_group_name = module.vpc.database_subnet_group_name

  db_name  = var.db_name
  username = var.db_user
  password = var.db_password

  vpc_security_group_ids = [module.sg_rds_mysql.security_group_id]

  skip_final_snapshot = true
}
