# deploy nginx ingress controller in a given namespace of the kind cluster
# Deployment needs to the done using the nginx-ingress helm chart (see
# 01-cluster-create/main.tf for details)
# Use nginx-helm-chart-values-template.yml to generate the values for the helm chart
# (hint: use the Terraform's templatefile function)
provider "helm" {
  kubernetes {
    config_path            = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = var.nginx_ingress.namespace
  }
}

resource "helm_release" "nginx_ingress" {
  depends_on = [kubernetes_namespace.ingress_nginx]
  name       = "nginx-ingress"
  namespace  = var.nginx_ingress.namespace
  chart      = var.nginx_ingress.chart_name 
  repository = var.nginx_ingress.chart_repository
  version    = var.nginx_ingress.chart_version 

  values = [
    templatefile("${path.module}/nginx-helm-chart-values-template.yaml", {
      ingressClassName = var.nginx_ingress.ingress_class_name
      replicas         = var.nginx_ingress.replicas
    })
  ]
}

data "template_file" "nginx_values" {
  template = file("${path.module}/nginx-helm-chart-values-template.yaml")

  vars = {
    ingressClassName = var.nginx_ingress.ingress_class_name
    replicas         = var.nginx_ingress.replicas
  }
}
