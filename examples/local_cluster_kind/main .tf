provider "helm" {
  kubernetes {
    host = module.bigdata-blueprint.kind_endpoint

    client_certificate     = module.bigdata-blueprint.kind_client_certificate
    client_key             = module.bigdata-blueprint.kind_client_key
    cluster_ca_certificate = module.bigdata-blueprint.kind_cluster_ca_certificate
  }
}

provider "kubectl" {
  host = module.bigdata-blueprint.kind_endpoint

  client_certificate     = module.bigdata-blueprint.kind_client_certificate
  client_key             = module.bigdata-blueprint.kind_client_key
  cluster_ca_certificate = module.bigdata-blueprint.kind_cluster_ca_certificate
  load_config_file       = false
}

module "bigdata-blueprint" {
  source  = "JPedro-loureiro/bigdata-blueprint/helm"
  version = "0.0.5"
  
  kind = true
  kind_cluster_name = "big-data-on-k8s-blueprint"
  kind_kubernetes_version = "v1.25.3"
  kind_worker_nodes = 2

  argcd_remote_helm_applications = {
    "spark_operator" = {
        application_name = "spark-operator"
        helm_repo_url = "https://googlecloudplatform.github.io/spark-on-k8s-operator"
        helm_chart_name = "spark-operator"
        helm_chart_version = "1.1.21"
        helm_values_path = "helm_values/spark_operator.yaml"
        namespace = "processing"
    }
  }
}
