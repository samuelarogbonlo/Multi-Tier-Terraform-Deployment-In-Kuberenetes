# create the required output(s) of the module here
output "nginx_ingress_app_version" {
  value = var.nginx_ingress.chart_version 
}

