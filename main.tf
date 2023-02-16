# Use the AzureRM provider
provider "azurerm" {
  features {}
}

# Create a subnet for the Application Gateway
resource "azurerm_subnet" "app_gateway_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnet_address_prefix]
}

# Create a public IP address for the Application Gateway
resource "azurerm_public_ip" "app_gateway_public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.public_ip_allocation_method
}

# Create a backend pool for the Application Gateway
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name                = var.backend_pool_name
  resource_group_name = var.resource_group_name
  loadbalancer_id     = module.app_gateway.app_gateway_id
}

# Create an HTTP listener for the Application Gateway
resource "azurerm_application_gateway_http_listener" "http_listener" {
  name                           = var.http_listener_name
  resource_group_name            = var.resource_group_name
  application_gateway_name       = module.app_gateway.app_gateway_name
  frontend_ip_configuration_name = "app_gateway_frontend_ip"
  frontend_port_name             = "app_gateway_frontend_port_http"
  protocol                       = "Http"
}

# Create an HTTPS listener for the Application Gateway

# resource "azurerm_application_gateway_https_listener" "https_listener" {
#   name                           = var.https_listener_name
#   resource_group_name            = var.resource_group_name
#   application_gateway_name       = azurerm_application_gateway.app_gateway.name
#   frontend_ip_configuration_name = "app_gateway_frontend_ip"
#   frontend_port_name             = "app_gateway_frontend_port_https"
#   protocol                       = "Https"
#   ssl_certificate                = base64decode(data.azurerm_key_vault_secret.ssl_cert.value)
#   require_server_name_indication = true
# }
