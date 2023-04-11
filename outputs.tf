#################### Kind | Local k8s cluster ####################

output "kind_kubeconfig" {
  value = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].kubeconfig : null
  description = "The kubeconfig for the kind cluster after it is created"
  sensitive = true
}

output "kind_client_certificate" {
  value = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].client_certificate : null
  description = "Client certificate for authenticating to kind cluster"
  sensitive = true
}

output "kind_client_key" {
  value = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].client_key : null
  description = "Client key for authenticating to kind cluster."
  sensitive = true
}

output "kind_cluster_ca_certificate" {
  value = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].cluster_ca_certificate : null
  description = "Client verifies the server certificate with this CA cert"
  sensitive = true
}

output "kind_endpoint" {
  value = var.kind ? kind_cluster.big-data-on-k8s-blueprint[0].endpoint : null
  description = "Kind APIServer endpoint"
  sensitive = false
}
