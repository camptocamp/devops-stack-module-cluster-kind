locals {
  docker_gateway = compact(data.docker_network.kind_network.ipam_config[*].gateway)[0]
  base_domain    = coalesce(var.base_domain, format("%s.nip.io", replace(local.docker_gateway, ".", "-")))
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

    # Because we need to map these ports to have access to the services and because the same ports 
    # cannot be mapped them on multiple containers, we chose to only deploy a single node. This is
    # because otherwise we would not be sure on which node Traefik would be deployed and it could 
    # arrive that it will be deployed on a node without a port mapping. 
    node {
      role = "control-plane"

      # TODO Add dynamic terraform blocks here to variabilize these blocks to maybe add 22 to GitLab for example
      extra_port_mappings {
        container_port = 80
        host_port      = 80
        protocol       = "TCP"
      }

      extra_port_mappings {
        container_port = 443
        host_port      = 443
        protocol       = "TCP"
      }
    }

  }
}
