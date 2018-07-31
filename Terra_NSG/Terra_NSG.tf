######################################################################
# Module NSG
######################################################################

### Variables

# NSG Name
variable "NSGName" {
  type    = "string"
  default = "DefaultNSGName"
}

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# NSG Location
variable "NSGLocation" {
  type    = "string"
  default = "Westeurope"
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

# Creation NSG
resource "azurerm_network_security_group" "Terra-NSG" {
  name                = "${var.NSGName}"
  location            = "${var.NSGLocation}"
  resource_group_name = "${var.RGName}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

### Outputs

output "Name" {
  value = "${azurerm_network_security_group.Terra-NSG.name}"
}

output "Id" {
  value = "${azurerm_network_security_group.Terra-NSG.id}"
}

output "RGName" {
  value = "${azurerm_network_security_group.Terra-NSG.resource_group_name}"
}
