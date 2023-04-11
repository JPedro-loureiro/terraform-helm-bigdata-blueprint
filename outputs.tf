#################### Kind | Local k8s cluster ####################

output "kind_kubeconfig" {
  value = kind_cluster.big-data-on-k8s-blueprint[0].kubeconfig
  description = "The kubeconfig for the kind cluster after it is created"
  sensitive = true
}

output "kind_client_certificate" {
  value = kind_cluster.big-data-on-k8s-blueprint[0].client_certificate
  description = "Client certificate for authenticating to kind cluster"
  sensitive = true
}

output "kind_client_key" {
  value = kind_cluster.big-data-on-k8s-blueprint[0].client_key
  description = "Client key for authenticating to kind cluster."
  sensitive = true
}

output "kind_cluster_ca_certificate" {
  value = kind_cluster.big-data-on-k8s-blueprint[0].cluster_ca_certificate
  description = "Client verifies the server certificate with this CA cert"
  sensitive = true
}

output "kind_endpoint" {
  value = kind_cluster.big-data-on-k8s-blueprint[0].endpoint
  description = "Kind APIServer endpoint"
  sensitive = false
}
