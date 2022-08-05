provider "azurerm" {
    
    subscription_id = ""
    client_id       = ""
    client_secret   = ""
    tenant_id       = ""
    features{}  
}
#=====================================================================#

resource "azurerm_resource_group" "aks_rg" {
    name = "${var.env}-rg"
    location = var.location
}

resource "azurerm_kubernetes_cluster" "my_aks" {
    name                = "${var.env}-aks"
    location            = var.location
    resource_group_name = azurerm_resource_group.aks_rg.name
    dns_prefix          = "exampleaks1"
  
    default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
    }


    identity {
        type = "SystemAssigned"
    }
}

locals {
  my_kube  = azurerm_kubernetes_cluster.my_aks.name
  resource = azurerm_resource_group.aks_rg.name
}

resource "null_resource" "start_kube" {
    depends_on = [
      azurerm_kubernetes_cluster.my_aks
    ]

    provisioner "local-exec" {
        command = <<-EOF
        cd .. &&
        az aks get-credentials --resource-group ${local.resource} --name ${local.my_kube} --overwrite-existing  &&
        bash apprun.sh
        EOF
    }
  
}