sudo -u nginx php /usr/share/nginx/html/wp-admin/install.php \
     --url=http://wp-alb-291061575.us-east-2.elb.amazonaws.com \
     --title="Your Website Title" \
     --admin_user=admin \
     --admin_password=adminpassword \
     --admin_email=admin@example.com