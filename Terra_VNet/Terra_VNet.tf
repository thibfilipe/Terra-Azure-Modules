######################################################################
# Creation Virtual Network
######################################################################

##################################################
### Variables
##################################################

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# VNet Location
variable "VnetLocation" {
  type    = "string"
  default = "Westeurope"
}

# Virtual Network Name
variable "VNetName" {
  type    = "string"
  default = "DefaultVNetName"
}

# Address Space
variable "AddressSpace" {
  type    = "list"
  default = ["10.0.0.0/20"]
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

##################################################
### Resource
##################################################

# Create Virtual Network
resource "azurerm_virtual_network" "Terra-VNet" {
  name                = "${var.VNetName}"
  address_space       = "${var.AddressSpace}"
  location            = "${var.VnetLocation}"
  resource_group_name = "${var.RGName}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

##################################################
### Outputs
##################################################

output "Name" {
  value = "${azurerm_virtual_network.Terra-VNet.name}"
}

output "Id" {
  value = "${azurerm_virtual_network.Terra-VNet.id}"
}

output "AddressSpace" {
  value = "${azurerm_virtual_network.Terra-VNet.address_space}"
}

output "RGName" {
  value = "${azurerm_virtual_network.Terra-VNet.resource_group_name}"
}

output "RGLocation" {
  value = "${azurerm_virtual_network.Terra-VNet.location}"
}
