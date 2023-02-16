# Declare a variable for the name of the resource group to contain the Application Gateway
variable "resource_group_name" {
  description = "The name of the resource group to contain the Application Gateway"
  type        = string
}

# Declare a variable for the location where the Application Gateway should be created
variable "location" {
  description = "The location where the Application Gateway should be created"
  type        = string
}

# Declare a variable for the name of the subnet where the Application Gateway should be deployed
variable "subnet_name" {
  description = "The name of the subnet where the Application Gateway should be deployed"
  type        = string
  default     = "app_gateway_subnet"
}

# Declare a variable for the address prefix of the subnet where the Application Gateway should be deployed
variable "subnet_address_prefix" {
  description = "The address prefix of the subnet where the Application Gateway should be deployed"
  type        = string
  default     = "10.0.1.0/24"
}

# Declare a variable for the name of the public IP address for the Application Gateway
variable "public_ip_name" {
  description = "The name of the public IP address for the Application Gateway"
  type        = string
  default     = "app_gateway_public_ip"
}

# Declare a variable for the allocation method of the public IP address for the Application Gateway
variable "public_ip_allocation_method" {
  description = "The allocation method of the public IP address for the Application Gateway"
  type        = string
  default     = "Dynamic"
}

# Declare a variable for the name of the Key Vault to store the SSL certificate
variable "key_vault_name" {
  description = "The name of the Key Vault to store the SSL certificate"
  type        = string
}

# Declare a variable for the SKU name of the Key Vault
variable "key_vault_sku_name" {
  description = "The SKU name of the Key Vault"
  type        = string
  default     = "standard"
}

# Declare a variable for the name of the SSL certificate
variable "ssl_cert_name" {
  description = "The name of the SSL certificate"
  type        = string
}

# Declare a variable for the name of the Application Gateway
variable "app_gateway_name" {
  description = "The name of the Application Gateway"
  type        = string
  default     = "app_gateway"
}

# Declare a variable for the SKU name of the Application Gateway
variable "app_gateway_sku_name" {
  description = "The SKU name of the Application Gateway"
  type        = string
  default     = "Standard_v2"
}

# Declare a variable for the number of instances of the Application Gateway
variable "app_gateway_capacity" {
  description = "The number of instances of the Application Gateway"
  type        = number
  default     = 2
}

# Declare a variable for the name of the backend pool
variable "backend_pool_name" {
  description = "The name of the backend pool"
  type        = string
  default     = "backend_pool"
}

# Declare a variable for the name of the HTTP listener for HTTP traffic
variable "http_listener_name" {
  description = "The name of the HTTP listener for HTTP traffic"
  type        = string
  default     = "http_listener"
}

# Declare a variable for the name of the HTTPS listener for HTTPS traffic
variable "https_listener_name" {
  description = "The name of the HTTPS listener for HTTPS traffic"
  type        = string
  default     = "https_listener"
}

# Declare a variable for the SSL certificate value
variable "ssl_cert_value" {
  description = "The value of the SSL certificate"
  type        = string
  default     = null
}

# Declare a variable for the name of the virtual network where the Application Gateway should be deployed
variable "virtual_network_name" {
  description = "The name of the virtual network where the Application Gateway should be deployed"
  type        = string
}

# Declare a variable for the list of IP addresses for the backend pool
variable "backend_ips" {
  description = "The list of IP addresses for the backend pool"
  type        = list(string)
}

# Declare a variable for the name of the backend pool health probe
variable "health_probe_name" {
  description = "The name of the backend pool health probe"
  type        = string
  default     = "health_probe"
}

#
#