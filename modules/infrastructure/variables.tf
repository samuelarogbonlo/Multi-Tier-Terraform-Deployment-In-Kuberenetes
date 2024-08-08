
variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the Kubernetes cluster"
  type        = string
}

variable "bucket_name" {
  description = "The name of the created s3 bucket"
  type        = string
}

variable "object_name" {
  description = "The name of the object"
  type        = string
}

variable "config_filename" {
  description = "The name of the configuration file"
  type        = string
}