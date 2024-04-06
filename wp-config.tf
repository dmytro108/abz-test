resource "random_string" "auth_key" {
  length  = 64
  special = false
}

resource "random_string" "secure_auth_key" {
  length  = 64
  special = false
}

resource "random_string" "logged_in_key" {
  length  = 64
  special = false
}

resource "random_string" "nonce_key" {
  length  = 64
  special = false
}

resource "random_string" "auth_salt" {
  length  = 64
  special = false
}

resource "random_string" "secure_auth_salt" {
  length  = 64
  special = false
}

resource "random_string" "logged_in_salt" {
  length  = 64
  special = false
}

resource "random_string" "nonce_salt" {
  length  = 64
  special = false
}

resource "local_file" "wp_config" {
  filename = var.wp_config_file
  content = templatefile("${var.wp_config_template}",
    {
      database_name     = aws_db_instance.mysql.db_name
      database_user     = aws_db_instance.mysql.username
      database_password = var.db_password
      database_host     = aws_db_instance.mysql.address

      auth_salt        = random_string.auth_salt.result
      auth_key         = random_string.auth_key.result
      secure_auth_salt = random_string.secure_auth_salt.result
      secure_auth_key  = random_string.secure_auth_key.result
      logged_in_salt   = random_string.logged_in_salt.result
      logged_in_key    = random_string.logged_in_key.result
      nonce_salt       = random_string.nonce_salt.result
      nonce_key        = random_string.nonce_key.result
    }
  )
}
