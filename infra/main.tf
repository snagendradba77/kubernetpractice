provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Example: Create a namespace for app and db
resource "kubernetes_namespace" "app_ns" {
  metadata {
    name = "flask-app-ns"
  }
}

resource "kubernetes_namespace" "db_ns" {
  metadata {
    name = "db-ns"
  }
}

# Example ConfigMap (optional)
resource "kubernetes_config_map" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace.app_ns.metadata[0].name
  }

  data = {
    APP_ENV = "dev"
  }
}

