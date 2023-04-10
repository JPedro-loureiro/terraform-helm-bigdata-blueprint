resource "kind_cluster" "big-data-on-k8s-blueprint" {
  count = var.kind ? 1 : 0

  name            = "${var.kind_cluster_name}-${var.env}"
  node_image      = "kindest/node:${var.kind_kubernetes_version}"
  kubeconfig_path = pathexpand("~/.kube/config")

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }

    dynamic "node" {
      for_each = range(var.kind_worker_nodes)
      content {
        role = "worker"
      }
    }
  }
}

#################### Nginx Ingress Controller Release ####################

# data "kubectl_file_documents" "nginx_ingress_controller" {
#     content = file("manifests/kind/nginx_ingress_controller.yaml")
# }

# resource "kubectl_manifest" "nginx_ingress_controller" {
#     for_each  = data.kubectl_file_documents.nginx_ingress_controller.manifests
#     yaml_body = each.value

#     depends_on = [
#         kind_cluster.big-data-on-k8s-blueprint
#     ]
# }
