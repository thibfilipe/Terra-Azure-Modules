######################################################################
# Module Subnet
######################################################################

### Variables

# Subnet Name
variable "SubnetName" {
  type    = "string"
  default = "DefaultSubnetName"
}

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Azure Region
variable "SubnetLocation" {
  type    = "string"
  default = "Westeurope"
}

# Virtual Network Name
variable "VNetName" {
  type    = "string"
  default = "DefaultVNetName"
}

# Subnet Address Prefix
variable "SubnetAddressPrefix" {
  type    = "string"
  default = "10.0.1.0/24"
}

# NSG Id
variable "NSGid" {
  type = "string"
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

# Create Subnet
resource "azurerm_subnet" "Terra-Subnet" {
  name                      = "${var.SubnetName}"
  resource_group_name       = "${var.RGName}"
  virtual_network_name      = "${var.VNetName}"
  address_prefix            = "${var.AddressPrefix}"
  network_security_group_id = "${var.NSGid}"
}

### Outputs

output "Name" {
  value = "${azurerm_subnet.Terra-Subnet.name}"
}

output "Id" {
  value = "${azurerm_subnet.Terra-Subnet.id}"
}

output "VNetName" {
  value = "${azurerm_subnet.Terra-Subnet.virtual_network_name}"
}

output "AddressPrefix" {
  value = "${azurerm_subnet.Terra-Subnet.address_prefix}"
}
