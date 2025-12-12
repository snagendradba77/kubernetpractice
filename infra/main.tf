# -------------------------------
# Provider
# -------------------------------
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# -------------------------------
# Namespaces
# -------------------------------
resource "kubernetes_namespace_v1" "app_ns" {
  metadata {
    name = "flask-app-ns"
  }

  lifecycle {
    prevent_destroy = true  # prevents accidental deletion
  }
}

resource "kubernetes_namespace_v1" "db_ns" {
  metadata {
    name = "db-ns"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# -------------------------------
# ConfigMap for Flask App
# -------------------------------
resource "kubernetes_config_map_v1" "app_config" {
  metadata {
    name      = "app-config"
    namespace = kubernetes_namespace_v1.app_ns.metadata[0].name
  }

  data = {
    APP_ENV = "dev"
  }

  lifecycle {
    # Ignore changes to the resource if it already exists with different data
    ignore_changes = [data]
  }
}

# -------------------------------
# Secret for PostgreSQL
# -------------------------------
resource "kubernetes_secret_v1" "postgres_secret" {
  metadata {
    name      = "postgres-secret"
    namespace = kubernetes_namespace_v1.db_ns.metadata[0].name
  }

  type = "Opaque"

  data = {
    POSTGRES_USER     = base64encode("postgres")
    POSTGRES_PASSWORD = base64encode("StrongPassword123")
  }

  lifecycle {
    ignore_changes = [data]
  }
}

