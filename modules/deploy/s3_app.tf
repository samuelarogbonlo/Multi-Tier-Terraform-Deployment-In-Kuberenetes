# deploy the dummy S3 app in the kind cluster in a given namespace.
# Check 02-app-deploy/main.tf for all the details of the app.

# The app should be accessible from localhost via an Ingress on localhost:8086/s3-app
# The app is stateless. No TLS is required (plain HTTP)

# Hint: pay attention to ingressClassName value of the Ingress object for the solution to work

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "s3_app" {
  metadata {
    name = var.s3_app.namespace
  }
}

locals {
  s3_app_port = tonumber(
    lookup(
      { for v in var.s3_app.env_vars : v.name => v.value if v.name == "PORT" },
      "PORT",
      "0"
    )
  )
}

resource "kubernetes_deployment" "s3_app" {
  metadata {
    name      = "s3-app"
    namespace = var.s3_app.namespace
    labels    = var.s3_app.labels
  }

  spec {
    replicas = var.s3_app.replicas

    selector {
      match_labels = var.s3_app.labels
    }

    template {
      metadata {
        labels = var.s3_app.labels
      }

      spec {
        container {
          name  = "s3-app"
          image = var.s3_app.image

          dynamic "env" {
            for_each = var.s3_app.env_vars
            content {
              name  = env.value.name
              value = env.value.value
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "s3_app" {
  metadata {
    name      = "s3-app"
    namespace = var.s3_app.namespace
    labels    = var.s3_app.labels
  }

  spec {
    ingress_class_name = var.s3_app.ingress_class_name

    rule {
      http {
        path {
          path     = var.s3_app.ingress_path
          path_type = "Prefix"
          backend {
            service {
              name = "s3-app"
              port {
                number = local.s3_app_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "s3_app" {
  metadata {
    name      = "s3-app"
    namespace = var.s3_app.namespace
    labels    = var.s3_app.labels
  }

  spec {
    selector = var.s3_app.labels

    port {
      port        = local.s3_app_port
      target_port = local.s3_app_port
    }
  }
}

