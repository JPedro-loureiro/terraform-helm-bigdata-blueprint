#################### General ####################

variable "env" {
  description = "The environment where the applications should be deployed"
  type        = string
  default     = "dev"
}

#################### Kind | Local k8s cluster ####################

variable "kind" {
  description = "Controls if a Kind cluster should be deployed to support all the applications. If true, the module will deploy a local kind cluster"
  type        = bool
  default     = false
}

variable "kind_cluster_name" {
  description = "The cluster identifier"
  type        = string
  default     = null
}

variable "kind_kubernetes_version" {
  description = "The Kubernetes version to deploy"
  type        = string
  default     = null
}

variable "kind_worker_nodes" {
  description = "The number of worker nodes"
  type        = number
  default     = null
}

#################### Remote k8s Cluster ####################

variable "k8s_host" {
  description = "The hostname (in form of URI) of the Kubernetes API. This must be set if 'kind' is set to false"
  type        = string
  default     = null
}

variable "k8s_client_certificate" {
  description = "PEM-encoded client certificate for TLS authentication. This must be set if 'kind' is set to false"
  type        = string
  default     = null
}

variable "k8s_client_key" {
  description = "PEM-encoded client certificate key for TLS authentication. This must be set if 'kind' is set to false"
  type        = string
  default     = null
}

variable "k8s_cluster_ca_certificate" {
  description = "PEM-encoded root certificates bundle for TLS authentication. This must be set if 'kind' is set to false"
  type        = string
  default     = null
}

#################### ArgoCD Applications ####################

variable "argcd_remote_helm_applications" {
  description = "A map of all remote Helm Chart configurations"
  type = map(
    object({
      application_name = string
      helm_repo_url = string
      helm_chart_name = string
      helm_chart_version = string
      helm_values_path = string
      namespace = string
    })
  )
  default = {}
}

variable "argcd_git_applications" {
  description = "A map of all git repos configurations"
  type = map(
    object({
      application_name = string
      git_repo_url = string
      git_path = string
      namespace = string
    })
  )
  default = {}
}