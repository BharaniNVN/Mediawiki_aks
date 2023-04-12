resource "azurerm_resource_group" "aks_rg" {

  location = var.location
  name     = "rg-mediawiki"
}

resource "azurerm_container_registry" "acr" {
  name                = "mediawikiacr"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = var.location
  sku                 = "Premium"
  depends_on          = [azurerm_resource_group.aks_rg]
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "mediawikiaks"
  location            = var.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "mediawikiaks"

  default_node_pool {
    name   = "apppool"
    node_count = "1"
    vm_size    = "standard_d2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "LAB"
  }

  depends_on = [azurerm_container_registry.acr, azurerm_resource_group.aks_rg]
}

resource "azurerm_role_assignment" "acr-aks" {
  principal_id                     = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
  depends_on                       = [azurerm_container_registry.acr, azurerm_kubernetes_cluster.cluster, azurerm_resource_group.aks_rg]
}

resource "local_file" "kubeconfig" {
  filename       = "kubeconfig"
  depends_on = [azurerm_kubernetes_cluster.cluster, azurerm_resource_group.aks_rg, azurerm_container_registry.acr ]
  content    = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive = true
}
