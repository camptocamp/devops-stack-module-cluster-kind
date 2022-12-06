locals {
  docker_gateway = compact(data.docker_network.kind_network.ipam_config[*].gateway)[0]
  base_domain    = coalesce(var.base_domain, format("%s.nip.io", replace(local.docker_gateway, ".", "-")))
  default_extra_port_mappings = [
    "tcp/80",
    "tcp/443",
  ]
}

data "docker_network" "kind_network" {
  # Name given to the Docker network by the kind_cluster resource so it cannot be anything other than `kind`.
  name       = "kind"
  depends_on = [kind_cluster.cluster]
}

resource "kind_cluster" "cluster" {
  name = var.cluster_name

  node_image = "kindest/node:${var.kubernetes_version}"

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      # Add annotation to specify that this node is where the ingress should be deployed.
      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      dynamic "extra_port_mappings" {
        for_each = toset(concat(local.default_extra_port_mappings, var.extra_port_mappings))
        content {
          host_port      = element(split("/", extra_port_mappings.value), 1)
          container_port = element(split("/", extra_port_mappings.value), 1)
          protocol       = upper(element(split("/", extra_port_mappings.value), 0))
        }
      }
    }

  }
}
