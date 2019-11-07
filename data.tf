data "template_file" "keybase_password_decrypt_command" {
  template = file(
    "${path.module}/templates/keybase_password_decrypt_command.sh",
  )

  vars = {
    encrypted_password = local.encrypted_password
  }
}

data "template_file" "keybase_password_pgp_message" {
  template = file("${path.module}/templates/keybase_password_pgp_message.txt")

  vars = {
    encrypted_password = local.encrypted_password
  }
}


data "template_file" "keybase_secret_decrypt_command" {
  template = file(
    "${path.module}/templates/keybase_secret_decrypt_command.sh",
  )

  vars = {
    encrypted_secret = local.encrypted_secret
  }
}

data "template_file" "keybase_secret_pgp_message" {
  template = file("${path.module}/templates/keybase_secret_pgp_message.txt")

  vars = {
    encrypted_secret = local.encrypted_secret
  }
}

data "template_file" "welcome_aws_api" {
  template = file("${path.module}/templates/welcome_aws_api.txt")

  vars = {
    username = element(concat(aws_iam_user.default.*.name, [""]), 0)
    access_key_id = element(concat(aws_iam_access_key.default.*.id, [""]),0,)
    secret_decrypt_command = local.keybase_secret_decrypt_command
    encrypted_secret = local.encrypted_secret
  }
}

data "template_file" "welcome_aws_console" {
  template = file("${path.module}/templates/welcome_aws_console.txt")

  vars = {
    account_alias = var.account_alias
    account_signin_url = var.account_signin_url
    username = element(concat(aws_iam_user.default.*.name, [""]), 0)
    password_decrypt_command = local.keybase_password_decrypt_command
  }
}
