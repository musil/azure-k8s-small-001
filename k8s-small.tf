# Create a resource group
resource "azurerm_resource_group" "rg-k8s-small-001" {
  name     = "rs-k8s-small-001"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet-k8s-small-001" {
  name                = "vnet-k8s-small-001"
  location            = azurerm_resource_group.rg-k8s-small-001.location
  resource_group_name = azurerm_resource_group.rg-k8s-small-001.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  virtual_network_name = azurerm_virtual_network.vnet-k8s-small-001.name
  resource_group_name  = azurerm_resource_group.rg-k8s-small-001.name
  address_prefixes     = ["10.1.0.0/22"]
}

resource "azurerm_kubernetes_cluster" "k8s-small-001" {
  name                = "aks-small-001"
  location            = azurerm_resource_group.rg-k8s-small-001.location
  resource_group_name = azurerm_resource_group.rg-k8s-small-001.name
  dns_prefix          = "aks-small-001"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_B2s"
    enable_auto_scaling = false
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "calico"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

  #tags = {
  #  Environment = "Production"
  #}

  #zones = ["1", "2"]
  #api_server_authorized_ip_ranges  = ["YOUR_IP/32"]
  azure_policy_enabled             = true
  http_application_routing_enabled = true
  #loadBalancerSku                  = "standard"
  #network_plugin                   = "calico"
  private_cluster_enabled = false

}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.k8s-small-001.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s-small-001.kube_config_raw
  sensitive = true
}

output "id" {
  value = azurerm_kubernetes_cluster.k8s-small-001.id
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.k8s-small-001.kube_config.0.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.k8s-small-001.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.k8s-small-001.kube_config.0.host
  sensitive = true
}
