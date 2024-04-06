locals {
  # map of private and bublic subnets CIDRs, if VPC CIDR is 10.x.y.0/16:
  # {
  #   private_subnet_cidrs: 10.x.y.0/24
  #   public_subnet_cidrs: 10.x.1y.0/24
  #   rds_subnet_cidrs: 10.x.2y.0/24
  #   elasticache_subnet_cidrs: 10.x.3y.0/24
  # }
  private_subnet_num     = var.replica_num
  public_subnet_num      = var.replica_num
  rds_subnet_num         = var.replica_num
  elasticache_subnet_num = var.replica_num

  cidrs = {
    private_subnet_cidrs     = [for y in range(local.private_subnet_num) : cidrsubnet(var.vpc_cidr, 8, y)]
    public_subnet_cidrs      = [for y in range(local.public_subnet_num) : cidrsubnet(var.vpc_cidr, 8, 10 + y)]
    rds_subnet_cidrs         = [for y in range(local.rds_subnet_num) : cidrsubnet(var.vpc_cidr, 8, 20 + y)]
    elasticache_subnet_cidrs = [for y in range(local.elasticache_subnet_num) : cidrsubnet(var.vpc_cidr, 8, 30 + y)]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  azs             = var.azs
  name            = var.vpc_name
  cidr            = var.vpc_cidr
  private_subnets = local.cidrs.private_subnet_cidrs
  public_subnets  = local.cidrs.public_subnet_cidrs

  elasticache_subnets           = local.cidrs.elasticache_subnet_cidrs
  elasticache_subnet_group_name = "redis-subnets"

  database_subnets           = local.cidrs.rds_subnet_cidrs
  database_subnet_group_name = "musql-subnets"

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.env_name
  }
}
