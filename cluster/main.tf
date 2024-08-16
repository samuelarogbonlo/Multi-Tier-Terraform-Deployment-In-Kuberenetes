terraform {
  required_version = ">= 1.5.0"
}

locals {
  cluster_name         = "test-cluster"
  cluster_version      = "1.28.0"
  bucket_name          = "test-bucket"
  object_key           = "test-file"
  object_contents_file = "bucket-file.json"
}

module "infrastructure" {
  source          = "../modules/infrastructure"
  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version
  bucket_name     = local.bucket_name
  object_name     = local.object_key
  config_filename = local.object_contents_file
}

output "cluster_endpoint" {
  value = module.infrastructure.cluster_endpoint
}
