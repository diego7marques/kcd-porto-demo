resource "azurerm_virtual_network" "vnet" {
  name                = "k8gb-kcdporto-vnet"
  resource_group_name = "k8gb-kcdporto2024"
  address_space       = ["10.10.0.0/16"]
  location            = "northeurope"
}

resource "azurerm_subnet" "k8s" {
  name                 = "k8s"
  resource_group_name  = "k8gb-kcdporto2024"
  virtual_network_name = azurerm_virtual_network.vnet.name
  #service_endpoints    = ["Microsoft.KeyVault"]
  address_prefixes = ["10.10.0.0/16"]
}