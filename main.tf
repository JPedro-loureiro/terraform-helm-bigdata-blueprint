#################### ArgoCD Release ####################

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "cicd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"

  set {
    name  = "configs.secret.argocdServerAdminPassword"
    value = "$2a$10$f8EpEf6KCABClo2Zewo6uO3kJGZS59Th.DtuTUsZOGgO8mC3GEE9G"
  }
}

#################### ArgoCD Projects ####################

locals {
  helm_repos = join(
    "\n",
    formatlist(
        "    - %s",
        [for conf_idx, app_conf in values(var.argcd_remote_helm_applications) : lookup(app_conf, "helm_repo_url")]
    )
  )
  git_repos = join(
    "\n",
    formatlist(
        "    - %s",
        [for conf_idx, app_conf in values(var.argcd_git_applications) : lookup(app_conf, "git_repo_url")]
    )
  )
  repositories = join("\n", tolist([local.helm_repos, local.git_repos]))
}

resource "kubectl_manifest" "argocd_projects_deployment" {
  yaml_body = templatefile(
    "manifests/argocd/projects.yaml",
    {
      repositories = replace(local.repositories, "\n", "\n    ")
    }
  )
  depends_on = [
    helm_release.argocd
  ]
}

#################### ArgoCD Applications for remote Helm Repos ####################

resource "kubectl_manifest" "apply_remote_application" {
  for_each = var.argcd_remote_helm_applications
  yaml_body = templatefile(
    "manifests/argocd/remote_applications_template.yaml",
    {
      name = each.value.application_name
      helm_repo_url = each.value.helm_repo_url
      helm_chart_version = each.value.helm_chart_version
      helm_chart_name = each.value.helm_chart_name
      values  = replace(file(each.value.helm_values_path), "\n", "\n        ")
      namespace = each.value.namespace
    }
  )
  depends_on = [
    kubectl_manifest.argocd_projects_deployment
  ]
}

#################### ArgoCD Applications for Git Repos ####################

resource "kubectl_manifest" "apply_git_application" {
  for_each = var.argcd_git_applications
  yaml_body = templatefile(
    "manifests/argocd/git_applications_template.yaml",
    {
      name = each.value.application_name
      git_repo_url = each.value.git_repo_url
      git_path = each.value.git_path
      namespace = each.value.namespace
    }
  )
  depends_on = [
    kubectl_manifest.argocd_projects_deployment
  ]
}