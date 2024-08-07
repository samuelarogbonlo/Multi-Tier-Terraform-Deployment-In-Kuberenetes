# TODO: use this file configure the module to use the latest version of provider tehcyx/kind.
# The provider readme: https://registry.terraform.io/providers/tehcyx/kind/latest/docs/resources/cluster
terraform {
  required_providers {
    kind = {
      source = "tehcyx/kind"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
  }
}

provider "kind" {}

