# create the required output(s) of the module here
output "nginx_ingress_app_version" {
  value = helm_release.nginx_ingress.version
}

