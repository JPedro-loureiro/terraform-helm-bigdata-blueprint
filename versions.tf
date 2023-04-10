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

# provider "kind" {}

# provider "helm" {
#   kubernetes {
#     host = kind_cluster.big-data-on-k8s-blueprint[0].endpoint

#     client_certificate     = kind_cluster.big-data-on-k8s-blueprint[0].client_certificate
#     client_key             = kind_cluster.big-data-on-k8s-blueprint[0].client_key
#     cluster_ca_certificate = kind_cluster.big-data-on-k8s-blueprint[0].cluster_ca_certificate
#   }
# }

# provider "kubectl" {
#   host = kind_cluster.big-data-on-k8s-blueprint[0].endpoint

#   client_certificate     = kind_cluster.big-data-on-k8s-blueprint[0].client_certificate
#   client_key             = kind_cluster.big-data-on-k8s-blueprint[0].client_key
#   cluster_ca_certificate = kind_cluster.big-data-on-k8s-blueprint[0].cluster_ca_certificate
#   load_config_file       = false
# }

# provider "local" {}