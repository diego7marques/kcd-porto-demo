resource "azurerm_kubernetes_cluster" "k8s" {
  name                      = "k8gb-kcdporto-azure"
  location                  = "northeurope"
  resource_group_name       = "k8gb-kcdporto2024"
  dns_prefix                = "k8gb-kcdporto"
  kubernetes_version        = "1.30"
  sku_tier                  = "Standard"
  azure_policy_enabled      = false
  image_cleaner_enabled     = false
  oidc_issuer_enabled       = true
  node_resource_group       = "MC_k8gb-kcdporto2024"


  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                          = "default"
    temporary_name_for_rotation   = "defaulttemp"
    auto_scaling_enabled  = true
    min_count                     = 1
    max_count                     = 3
    max_pods                      = 100
    vm_size                       = "Standard_B2ms"
    zones                         = ["1", "2", "3"]
    vnet_subnet_id                = azurerm_subnet.k8s.id
  }

  network_profile {
    network_plugin = "azure"
    network_mode   = "transparent"
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
}