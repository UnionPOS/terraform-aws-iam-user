output "keybase_password_decrypt_command" {
  # https://stackoverflow.com/questions/36565256/set-the-aws-console-password-for-iam-user-with-terraform
  description = "Command to decrypt the Keybase encrypted password"
  value       = local.keybase_password_decrypt_command
}

output "keybase_password_pgp_message" {
  description = "PGP encrypted message (e.g. suitable for email exchanges)"
  value       = local.keybase_password_pgp_message
}

output "keybase_secret_decrypt_command" {
  # https://stackoverflow.com/questions/36565256/set-the-aws-console-password-for-iam-user-with-terraform
  description = "Command to decrypt the Keybase encrypted secret"
  value       = local.keybase_secret_decrypt_command
}

output "keybase_secret_pgp_message" {
  description = "PGP encrypted message (e.g. suitable for email exchanges)"
  value       = local.keybase_secret_pgp_message
}

output "user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = element(concat(aws_iam_user.default.*.arn, [""]), 0)
}

output "user_name" {
  description = "IAM user name"
  value       = element(concat(aws_iam_user.default.*.name, [""]), 0)
}

output "user_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value = element(
    concat(
      aws_iam_access_key.default.*.encrypted_secret,
      [""],
    ),
    0,
  )
}

output "user_access_key_id" {
  description = "The access key ID."
  value = element(
    concat(aws_iam_access_key.default.*.id, [""]),
    0,
  )
}

output "user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value = element(
    concat(
      aws_iam_user_login_profile.default.*.encrypted_password,
      [""],
    ),
    0,
  )
}

output "user_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value = element(
    concat(aws_iam_user_login_profile.default.*.key_fingerprint, [""]),
    0,
  )
}

output "user_pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user"
  value       = var.pgp_key
}

output "user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = element(concat(aws_iam_user.default.*.unique_id, [""]), 0)
}
