output "parsed_kubeconfig" {
  description = "Kubeconfig blocks to configure Terraform providers."
  value = {
    host                   = kind_cluster.cluster.endpoint
    client_certificate     = kind_cluster.cluster.client_certificate
    client_key             = kind_cluster.cluster.client_key
    cluster_ca_certificate = kind_cluster.cluster.cluster_ca_certificate
  }
  sensitive = true
}

output "raw_kubeconfig" {
  description = "Raw `.kube/config` file for `kubectl` access."
  value       = kind_cluster.cluster.kubeconfig
  sensitive   = true
}

output "kind_subnet" {
  description = "Kind IPv4 Docker network subnet."
  value       = tolist(data.docker_network.kind.ipam_config[*].subnet).1
}
