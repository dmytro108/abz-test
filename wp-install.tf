resource "local_file" "wp_install" {
  filename = var.wp_install_file
  content = templatefile("${var.wp_install_template}",
    {
      website_url = module.wp_alb.lb_dns_name
    }
  )
}
