# create code to create a kind cluster using Terraform,
# with the following equivalent configuration:
# (see providers.tf for the provider information and settings)

# Important: make sure nothing runs on your port 8086 locally
# (otherwise the kind cluster's port binding won't work)

# ---
# kind: Cluster
# apiVersion: kind.x-k8s.io/v1alpha4
# name: <cluster-name>
# nodes:
# - role: control-plane
#   image: kindest/node:v<k8s-version>
# - role: worker
#   image: kindest/node:v<k8s-version>
#   extraPortMappings:
#   - containerPort: 80
#     hostPort: 8086
#     listenAddress: "0.0.0.0"


resource "kind_cluster" "default" {
  name = var.cluster_name
  node_image = "kindest/node:v${var.cluster_version}"
  wait_for_ready = true
  kind_config {
    kind = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }

    node {
      role = "worker"
      extra_port_mappings {
            container_port = 80
            host_port      = 8086
            listen_address = "0.0.0.0"
          }
    }
  }
}

provider "kubectl" {
  host = "${kind_cluster.default.endpoint}"
  cluster_ca_certificate = "${kind_cluster.default.cluster_ca_certificate}"
  client_certificate = "${kind_cluster.default.client_certificate}"
  client_key = "${kind_cluster.default.client_key}"
}
