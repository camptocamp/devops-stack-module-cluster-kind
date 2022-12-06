output "cluster_name" {
  description = "The name to given to the cluster."
  value       = var.cluster_name
}

output "base_domain" {
  description = "The base domain used for ingresses. By default it generated using the IP of the Docker network and a *.nip.io domain."
  value       = local.base_domain
}

output "kubernetes_host" {
  description = "Host for the endpoint of the KinD cluster."
  value       = kind_cluster.cluster.endpoint
}

output "kubernetes_client_certificate" {
  description = "Client certificate of the KinD cluster."
  value       = kind_cluster.cluster.client_certificate
}

output "kubernetes_client_key" {
  description = "Key certificate of the KinD cluster."
  value       = kind_cluster.cluster.client_key
}

output "kubernetes_cluster_ca_certificate" {
  description = "Certificate Authority of the KinD cluster."
  value       = kind_cluster.cluster.cluster_ca_certificate
}

output "kubernetes_kubeconfig" {
  description = "Configuration that can be copied into `.kube/config in order to access the cluster with `kubectl`."
  value       = kind_cluster.cluster.kubeconfig
}
