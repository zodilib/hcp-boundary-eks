terraform {
  required_providers {
    boundary = {
      version = "~> 1.0.11"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "" 
}
