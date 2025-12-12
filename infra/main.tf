# Reference existing namespaces instead of creating them
data "kubernetes_namespace_v1" "app_ns" {
  metadata {
    name = "flask-app-ns"
  }
}

data "kubernetes_namespace_v1" "db_ns" {
  metadata {
    name = "db-ns"
  }
}

resource "kubernetes_config_map_v1" "app_config" {
  metadata {
    name      = "app-config"
    namespace = data.kubernetes_namespace_v1.app_ns.metadata[0].name
  }
  data = {
    APP_ENV = "dev"
  }
}

resource "kubernetes_secret_v1" "postgres_secret" {
  metadata {
    name      = "postgres-secret"
    namespace = data.kubernetes_namespace_v1.db_ns.metadata[0].name
  }
  type = "Opaque"
  data = {
    POSTGRES_USER     = base64encode("postgres")
    POSTGRES_PASSWORD = base64encode("StrongPassword123")
  }
}

