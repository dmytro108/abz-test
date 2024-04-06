# Coonect to the hosts incide the VPC:
/*
 > aws ec2-instance-connect open-tunnel \
        --instance-id <instance_id> \
        --local-port <local_port> &
*/
# SSh connection:
# > ssh  ec2-user@localhost -p <local_port>
#
resource "aws_ec2_instance_connect_endpoint" "tunnel" {
  subnet_id          = module.vpc.private_subnets[0]
  security_group_ids = [module.sg_tunnel.security_group_id]
}


# SSH public key
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = var.my_pub_key
}
