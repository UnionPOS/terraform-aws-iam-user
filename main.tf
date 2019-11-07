locals {
  encrypted_password = element(
    concat(
      aws_iam_user_login_profile.default.*.encrypted_password,
      [""],
    ),
    0,
  )
  encrypted_secret = element(
    concat(
      aws_iam_access_key.default.*.encrypted_secret,
      [""],
    ),
    0,
  )
  keybase_password_pgp_message = data.template_file.keybase_password_pgp_message.rendered
  keybase_password_decrypt_command = data.template_file.keybase_password_decrypt_command.rendered
  keybase_secret_pgp_message = data.template_file.keybase_secret_pgp_message.rendered
  keybase_secret_decrypt_command = data.template_file.keybase_secret_decrypt_command.rendered
  welcome_aws_api_message = data.template_file.welcome_aws_api.rendered
  welcome_aws_console_message = data.template_file.welcome_aws_console.rendered
}

// https://www.terraform.io/docs/providers/aws/r/iam_user.html
resource "aws_iam_user" "default" {
  count = var.enabled ? 1 : 0

  name                 = var.name
  path                 = var.path
  permissions_boundary = var.permissions_boundary
  force_destroy        = var.force_destroy
}

// https://www.terraform.io/docs/providers/aws/r/iam_user_login_profile.html
resource "aws_iam_user_login_profile" "default" {
  count = var.enabled && var.login_profile_enabled ? 1 : 0

  user                    = aws_iam_user.default[0].name
  pgp_key                 = var.pgp_key
  password_length         = var.password_length
  password_reset_required = var.password_reset_required
  depends_on              = [aws_iam_user.default]
}

// https://www.terraform.io/docs/providers/aws/r/iam_user_group_membership.html
resource "aws_iam_user_group_membership" "default" {
  count      = var.enabled && length(var.groups) > 0 ? 1 : 0

  user       = aws_iam_user.default[0].name
  groups     = var.groups
  depends_on = [aws_iam_user.default]
}

// https://www.terraform.io/docs/providers/aws/r/iam_access_key.html
resource "aws_iam_access_key" "default" {
  count = var.enabled && var.access_key_enabled && var.pgp_key != "" ? 1 : 0

  user    = aws_iam_user.default[0].name
  pgp_key = var.pgp_key
  status  = var.access_key_status
}

// https://www.terraform.io/docs/providers/aws/r/iam_user_ssh_key.html
resource "aws_iam_user_ssh_key" "default" {
  count = var.enabled && var.rsa_key != "" ? 1 : 0

  username   = aws_iam_user.default[0].name
  encoding   = var.rsa_key_encoding
  public_key = var.rsa_key
  status     = var.rsa_key_status
}

// automagically dispatch welcome email message
module "email_console_login" {
  enabled = var.enabled && var.login_profile_enabled && var.email != "" ? true : false

  source     = "git::https://github.com/UnionPOS/terraform-null-smtp-mail.git?ref=up"
  body       = local.welcome_aws_console_message 
  subject    = "AWS Web Console Credentials updated"
  to         = [
    var.email
  ]
}

// automagically dispatch welcome email message
module "email_access_keys" {
  enabled = var.enabled && var.access_key_enabled  && var.email != "" ? true : false

  source     = "git::https://github.com/UnionPOS/terraform-null-smtp-mail.git?ref=up"
  body       = local.welcome_aws_api_message 
  subject    = "AWS API Access Keys updated"
  to         = [
    var.email
  ]
}
