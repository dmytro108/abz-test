# ******************************** Common vars
variable "region" {
  description = "AWS region for all recources and providers"
  type        = string
  default     = "us-east-2"
}
variable "azs" {
  description = "AWS availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}
variable "env_name" {
  description = "Environment tag"
  type        = string
  default     = "abz-test"
}

# ***************************** VPC
variable "vpc_name" {
  description = "VPC name tag"
  type        = string
  default     = "sandbox"
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

# ******************************* 
variable "replica_num" {
  description = "Number of replicated resources like ec2 instances"
  type        = number
  default     = 2
}
variable "private_subnet_num" {
  description = "Number of private subnets in the VPC"
  type        = number
  default     = 2
}
variable "public_subnet_num" {
  description = "Number of public subnets in the VPC"
  type        = number
  default     = 2
}
variable "rds_subnet_num" {
  description = "Number of subnets for RDS instances in the VPC"
  type        = number
  default     = 2
}
variable "elasticache_subnet_num" {
  description = "Number of subnets for Elasticache instances in the VPC"
  type        = number
  default     = 2
}
# ************************************ EC2
variable "ec2_ami_id" {
  description = "AWS ami id"
  type        = string
  default     = "ami-0900fe555666598a2" //AWS Linux 2023 x86_64  
}
variable "ec2_type" {
  description = "AWS instance type"
  type        = string
  default     = "t2.micro" // Free tier
}
variable "my_pub_key" {
  description = "SSH publick key for access to all hosts"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDMwEe5/F2MO9Pz2SDOmzO7scUyF/Al/0n3m+OWnKkad dmitr@Conqueror"
}

# ******************************* WP-Server
variable "name_pref" {
  description = "Prefix for all names in name tag"
  type        = string
  default     = "abz-"
}
variable "allowed_ip" {
  description = "Allowed IP addresses to connect webserver, by default no restrictions"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# ***************************** User
variable "user_name" {
  description = "username to login"
  type        = string
  default     = "jhon.d"
}
variable "user_path" {
  description = "Path for a user"
  type        = string
  default     = "/"
}

# ***************************** Ansible inventory template
variable "inventory_template" {
  description = "Path to template to produce Ansible inventory file"
  type        = string
  default     = "inventory.tftpl"
}
variable "inventory_file" {
  description = "Path to Ansible inventory file"
  type        = string
  default     = "./ansible/inventory/hosts.ini"
}

# ***************************** DB
variable "db_user" {
  type    = string
  default = "django"
}
variable "db_password" {
  type    = string
  default = "django123"
}
variable "db_name" {
  type    = string
  default = "django_db"
}

# **************************** Templates and output files
variable "wp_config_template" {
  description = "Path to template for wp-config.php"
  type        = string
  default     = "./templates/wp-config.tftpl"
}
variable "wp_config_file" {
  description = "Path to wp-config.php"
  type        = string
  default     = "./wordpress/admin/wp-config.php"
}

variable "wp_install_template" {
  description = "Path to template for wp-install.sh"
  type        = string
  default     = "./templates/wp-install.tftpl"
}
variable "wp_install_file" {
  description = "Path to wp-install.sh"
  type        = string
  default     = "./wordpress/wp-install.sh"
}
