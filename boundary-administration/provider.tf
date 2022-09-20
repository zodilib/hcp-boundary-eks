terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.0.12"
    }
  }
}

variable "boundary_addr" {
  type = string
}

variable "auth_method_id" {
  type = string
}

variable "password_auth_method_login_name" {
  type = string
}

variable "password_auth_method_password" {
  type = string
}

provider "boundary" {
  addr                            = var.boundary_addr
  auth_method_id                  = var.auth_method_id
  password_auth_method_login_name = var.password_auth_method_login_name
  password_auth_method_password   = var.password_auth_method_password
}
