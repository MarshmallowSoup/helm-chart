output "dns" {
    value =  azurerm_kubernetes_cluster.my_aks.fqdn
}

output "kubeconfig" {
  value     =  azurerm_kubernetes_cluster.my_aks.kube_admin_config_raw
  sensitive = true
}