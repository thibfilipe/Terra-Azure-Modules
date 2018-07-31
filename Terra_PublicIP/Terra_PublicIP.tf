############################################################
# Module Public IP
############################################################

### Variables

# Public IP Name
variable "PublicIPName" {
  type    = "string"
  default = "DefaultPublicIPName"
}

# Public IP Loacation
variable "PublicIPLocation" {
  type    = "string"
  default = "Westeurope"
}

# Public IP's Resource Group 
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Public IP Address Allocation
variable "PIPAddressAllocation" {
  type    = "string"
  default = "static"
}

# IP Address sku (basic or standard)
variable "PIPAddressSku" {
  type    = "string"
  default = "basic"
}

# Environement Tag
variable "EnvironmentTag" {
  type    = "string"
  default = "Environement Test"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Test Only"
}

### Resource

# Creating Public IP 
resource "azurerm_public_ip" "Terra-PublicIP" {
  name                         = "${var.PublicIPName}"
  location                     = "${var.PublicIPLocation}"
  resource_group_name          = "${var.RGName}"
  public_ip_address_allocation = "${var.PIPAddressAllocation}"
  sku                          = "${var.PIPAddressSku}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

### Outputs

output "Name" {
  value = "${azurerm_public_ip.Terra-PublicIP.name}"
}

output "Id" {
  value = "${azurerm_public_ip.Terra-PublicIP.id}"
}

output "IPAddress" {
  value = "${azurerm_public_ip.Terra-PublicIP.ip_address}"
}
