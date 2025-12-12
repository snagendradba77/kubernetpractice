provider "kubernetes" {
  config_path = "~/.kube/config"
}

# ConfigMap for Flask App
resource "kubernetes_config_map_v1" "app_config" {
  metadata {
    name      = "app-config"
    namespace = "flask-app-ns"  # existing namespace2
  }

  data = {
    APP_ENV = "dev"
  }
}

# Secret for PostgreSQL
resource "kubernetes_secret_v1" "postgres_secret" {
  metadata {
    name      = "postgres-secret"
    namespace = "db-ns"  # existing namespace
  }

  type = "Opaque"

  data = {
    POSTGRES_USER     = base64encode("postgres")
    POSTGRES_PASSWORD = base64encode("StrongPassword123")
  }
}

