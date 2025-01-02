variable "project_id" {
  type = string
}

variable "project_nmr" {
  type = number
}

variable "project_default_region" {
  type = string
}

variable "gcp_org_domain" {
  type = string
}

variable "cloud_asset_owner_principal" {
  type = string
}

variable "eligible_users_principals" {
  type = list(string)
}

variable "approver_principals" {
  type = list(string)
}