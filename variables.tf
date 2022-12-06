variable "cluster_name" {
  description = "The name to give to the cluster."
  type        = string
  default     = "kind"
}

variable "base_domain" {
  description = "The base domain used for ingresses."
  type        = string
  default     = null
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the KinD cluster (images available https://hub.docker.com/r/kindest/node/tags[here])."
  type        = string
  default     = "v1.25.3" # Define here the latest version of Kubernetes.
}

variable "extra_port_mappings" {
  description = "Map of extra ports to open on the control-plane node."
  type        = list(string)
  default     = ["tcp/80", "tcp/443"]
}
