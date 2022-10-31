output "cluster_name" {
  description = "" # TODO
  value       = var.cluster_name
}

output "base_domain" {
  description = "" # TODO
  value       = local.base_domain
}

output "kubernetes_host" {
  description = "" # TODO
  value       = kind_cluster.cluster.endpoint
}

output "kubernetes_client_certificate" {
  description = "" # TODO
  value       = kind_cluster.cluster.client_certificate
}

output "kubernetes_client_key" {
  description = "" # TODO
  value       = kind_cluster.cluster.client_key
}

output "kubernetes_cluster_ca_certificate" {
  description = "" # TODO
  value       = kind_cluster.cluster.cluster_ca_certificate
}

output "kubernetes_kubeconfig" {
  description = "" # TODO
  value       = kind_cluster.cluster.kubeconfig
}
