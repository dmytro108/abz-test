module "wp_alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "wp-alb"

  load_balancer_type = "application"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  security_groups = [module.sg_wp_alb.security_group_id]

  target_groups = [
    {
      name_prefix      = "app-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = {
        app_server_1 = {
          target_id = aws_instance.wp_servers[0].id
          port      = 80
        }
        app_server_2 = {
          target_id = aws_instance.wp_servers[1].id
          port      = 80
        }

      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

}
