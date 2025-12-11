output "app_namespace" {
  value = kubernetes_namespace.app_ns.metadata[0].name
}

output "db_namespace" {
  value = kubernetes_namespace.db_ns.metadata[0].name
}

