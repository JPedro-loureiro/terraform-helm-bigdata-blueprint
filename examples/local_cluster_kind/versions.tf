terraform {
  required_version = ">= 1.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    kind = {
      source  = "tehcyx/kind"
      version = "0.0.16"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}
