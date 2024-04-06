#output "public_ip" {
#  description = "WP server publick IP and DNS address"
#  value       = {
#    ip = aws_eip.wp-server_ip.public_ip
#    dns = aws_eip.wp-server_ip.public_dns
#  }
#}

output "alb_dns_name" {
  description = "WP server ALB  DNS name"
  value       = module.wp_alb.lb_dns_name
}

output "user" {
  description = "IAM User login and password"
  value = {
    login    = aws_iam_user_login_profile.abz.user
    password = aws_iam_user_login_profile.abz.password
  }
}

output "ec2_instances" {
  description = "Instance ID and name to connect through AWS instance tunnel endpoint."
  value = {
    for instance in aws_instance.wp_servers : instance.tags.Name => instance.id
  }
}
