
terraform {
  required_version = ">= 1.5.0"
}

locals {
  cluster_name         = "test-cluster"
  cluster_context      = "kind-${local.cluster_name}"
  ingress_class_name   = "da-nginx" #ingress class name to be used by the app
  bucket_name          = "test-bucket"
  object_key           = "test-file"
  object_contents_file = "../cluster/bucket-file.json"
}

module "deploy" {
  source = "../modules/deploy"

  nginx_ingress = {
    namespace          = "ingress-nginx"
    replicas           = 1
    ingress_class_name = local.ingress_class_name
    chart_repository   = "https://kubernetes.github.io/ingress-nginx"
    chart_name         = "ingress-nginx"
    chart_version      = "4.7.1"
  }

  s3_app = {
    namespace          = "s3-app"
    image              = "" #image to be used by the app
    replicas           = 1
    ingress_class_name = local.ingress_class_name
    ingress_path       = "/s3-app" # the app should be available locally on localhost:8086/s3-app
    labels = {
      app = "s3-app"
    }
    env_vars = [ # environment variables used by the app
      {
        name  = "S3_BUCKET"
        value = local.bucket_name
      },
      {
        name  = "S3_OBJECT"
        value = local.object_key
      },
      {
        name  = "AWS_ACCESS_KEY_ID"
        value = "mock_access_key" # these fake credentials are needed for the S3 app to work with Localstack
      },
      {
        name  = "AWS_SECRET_ACCESS_KEY"
        value = "mock_secret_key" # these fake credentials are needed for the S3 app to work with Localstack
      },
      {
        name  = "AWS_DEFAULT_REGION"
        value = "us-east-1" # this fake region is needed for the S3 app to work with Localstack
      },
      {
        name  = "S3_OBJECT_CONTENT_CHECKSUM"
        value = filemd5(local.object_contents_file)
      },
      {
        name  = "PORT"
        value = "8888"
      }
    ]
  }
}

output "nginx_ingress_app_version" {
  value = module.deploy.nginx_ingress_app_version
}
