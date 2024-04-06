resource "aws_instance" "wp_servers" {
  count = var.replica_num

  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_type
  subnet_id              = module.vpc.private_subnets[count.index]
  vpc_security_group_ids = [module.sg_wp_server.security_group_id]
  key_name               = aws_key_pair.my_key.key_name

  user_data = <<-EOF
                  #!/usr/bin/bash
                  sudo yum -y update
                  sudo yum install -y yum-utils nginx php php-fpm php-mysqlnd git

                  sudo wget https://wordpress.org/latest.tar.gz
                  sudo tar -xzf latest.tar.gz
                  sudo mv wordpress/* /usr/share/nginx/html && rm -rf wordpress
                  sudo chown -R nginx:nginx /usr/share/nginx/html/

                  sudo systemctl start nginx
                  sudo systemctl enable nginx

                  sudo systemctl start php-fpm
                  sudo systemctl enable php-fpm
              EOF

  tags = {
    "Name" = "${var.name_pref}wp-server-${count.index}"
  }
}


