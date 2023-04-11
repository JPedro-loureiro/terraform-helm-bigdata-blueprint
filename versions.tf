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

provider "helm" {
  kubernetes {
    host = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].endpoint : var.k8s_host

    client_certificate     = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].client_certificate : var.k8s_client_certificate
    client_key             = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].client_key : var.k8s_client_key
    cluster_ca_certificate = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].cluster_ca_certificate : var.k8s_cluster_ca_certificate
  }
}

provider "kubectl" {
    host = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].endpoint : var.k8s_host

    client_certificate     = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].client_certificate : var.k8s_client_certificate
    client_key             = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].client_key : var.k8s_client_key
    cluster_ca_certificate = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].cluster_ca_certificate : var.k8s_cluster_ca_certificate
  load_config_file       = false
}
