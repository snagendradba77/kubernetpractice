provider "kubernetes" {
  config_path = "~/.kube/config"
}

# -----------------------
# Namespaces
# -----------------------
resource "kubernetes_namespace_v1" "app_ns" {
  metadata {
    name = "flask-app-ns"
  }
}

resource "kubernetes_namespace_v1" "db_ns" {
  metadata {
    name = "db-ns"
  }
}

# -----------------------
# PostgreSQL Secret
# -----------------------
resource "kubernetes_secret_v1" "postgres_secret" {
  metadata {
    name      = "postgres-secret"
    namespace = kubernetes_namespace_v1.db_ns.metadata[0].name
  }

  data = {
    POSTGRES_USER     = base64encode("postgres")
    POSTGRES_PASSWORD = base64encode("password")
    POSTGRES_DB       = base64encode("appdb")
  }
}

# -----------------------
# Optional ConfigMap for App
# -----------------------
resource "kubernetes_config_map_v1" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace_v1.app_ns.metadata[0].name
  }

  data = {
    APP_ENV = "dev"
  }
}

