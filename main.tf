resource "kind_cluster" "cluster" {
  name = var.cluster_name

  node_image = "kindest/node:${var.kubernetes_version}"

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }
    # TODO variable for worker nodes with labels.
    node {
      role = "worker"
    }
    node {
      role = "worker"
    }
  }
}

data "docker_network" "kind" {
  name       = "kind"
  depends_on = [kind_cluster.cluster]
}
