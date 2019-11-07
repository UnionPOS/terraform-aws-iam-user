variable "access_key_enabled" {
  default     = true
  description = "Whether to create an IAM access key. This is a set of credentials that allow API requests to be made as an IAM user."
  type = bool
}

variable "access_key_status" {
  default     = "Active"
  description = "(Optional) The access key status to apply. Defaults to Active. Valid values are Active and Inactive."
  type = string
}

variable "account_alias" {
  default = ""
  description = "The Account Alias"
  type = string
}

variable "account_signin_url" {
  default = ""
  description = "The sign in url for the account"
  type = string
}

variable "enabled" {
  default     = true
  description = "Whether to create the IAM user"
  type = bool
}

variable "email" {
  default = ""
  description = "Email address for user"
  type = string
}

variable "force_destroy" {
  default     = true
  description = "When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  type = bool
}

variable "groups" {
  default     = []
  description = "List of IAM user groups this user should belong to in the account"
  type        = list(string)
}

variable "login_profile_enabled" {
  default     = true
  description = "Whether to create IAM user login profile"
  type = bool
}

variable "name" {
  description = "Desired name for the IAM user. We recommend using email addresses."
  type = string
}

variable "password_reset_required" {
  default     = true
  description = "Whether the user should be forced to reset the generated password on first login."
  type = bool
}

variable "password_length" {
  default     = 32
  description = "The length of the generated password"
  type = number
}

variable "path" {
  default     = "/users/"
  description = "Desired path for the IAM user"
  type = string
}

variable "permissions_boundary" {
  default     = ""
  description = "The ARN of the policy that is used to set the permissions boundary for the user"
  type = string
}

variable "pgp_key" {
  default = ""
  description = "(Required) Provide a base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Required to encrypt password."
  type = string
}

variable "rsa_key" {
  default = ""
  description = "(Required) The SSH public key. The public key must be encoded in ssh-rsa format or PEM format."
  type = string
}

variable "rsa_key_encoding" {
  default     = "SSH"
  description = "(Required) Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM."
  type = string
}

variable "rsa_key_status" {
  default     = "Active"
  description = "(Optional) The status to assign to the SSH public key. Active means the key can be used for authentication with an AWS CodeCommit repository. Inactive means the key cannot be used. Default is active."
  type = string
}
