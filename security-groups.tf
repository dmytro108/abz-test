# ************************* WP Server 
module "sg_wp_server" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "wp-server-sg"
  description = "Allowed ingress SSH and HTTP traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = var.allowed_ip
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  egress_rules        = ["all-all"]
}

# ******************* WP servers ALB 
module "sg_wp_alb" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "wp-alb-sg"
  description = "Allowed ingress HTTP/HTTPS traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
}

# ******************* RDS MySQL
module "sg_rds_mysql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "rds-mysql-sg"
  description = "Allowed ingress MySQL traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["mysql-tcp"]
  #egress_rules        = ["all-all"]
}

# ******************* Tunnel endpoint 
module "sg_tunnel" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "tunnel-sg"
  description = "Allowed ingress SSH traffic"
  vpc_id      = module.vpc.vpc_id

  # ingress_cidr_blocks = ["0.0.0.0/0"]
  # ingress_rules       = ["ssh-tcp"]
  #ingress_rules = ["all-all"]
  egress_rules = ["all-all"]
}
