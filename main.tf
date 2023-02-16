## Use the AzureRM provider
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
  backend_ips = var.backend_ips
  key_vault_url = var.key_vault_url
 }

# # Create the Application Gateway
resource "azurerm_application_gateway" "app_gateway" {
  name                = "myappgateway"
  resource_group_name = var.resource_group_name
  location            = var.location
  
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "app_gateway_ip_configuration"
    subnet_id = azurerm_subnet.app_gateway_subnet.id
  }
  frontend_port {
    name = "app_gateway_frontend_port_http"
    port = 80
  }
  frontend_port {
    name = "app_gateway_frontend_port_https"
    port = 443
  }
  frontend_ip_configuration {
  name = "app_gateway_frontend_ip"
  public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }
  backend_address_pool {
  name = azurerm_lb_backend_address_pool.backend_pool.name
  }
  http_listener {
  name = azurerm_application_gateway_http_listener.http_listener.name
  frontend_ip_configuration_name = "app_gateway_frontend_ip"
  frontend_port_name = "app_gateway_frontend_port_http"
  }
  http_listener {
  name = azurerm_application_gateway_https_listener.https_listener.name
  frontend_ip_configuration_name = "app_gateway_frontend_ip"
  frontend_port_name = "app_gateway_frontend_port_https"
  ssl_certificate_name = var.ssl_cert_name
  require_server_name_indication = true
  }
  }


# Create an HTTP listener for the Application Gateway


# http_listener {
#     name                           = var.https_listener_name
#     frontend_ip_configuration_name = "app_gateway_frontend_ip"
#     frontend_port_name             = "app_gateway_frontend_port_http"
#     protocol                       = "Http"
#   }

#
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
