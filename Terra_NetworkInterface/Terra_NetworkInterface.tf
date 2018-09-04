######################################################################
# Module Network Interface (No Public IP)
######################################################################

##################################################
### Variables
##################################################

# NIC Name
variable "NICName" {
  type    = "string"
  default = "DefaultNetworkInterfaceName"
}

# NIC Loaction
variable "NICLocation" {
  type    = "string"
  default = "Westeurope"
}

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# NSG ID
variable "NSGId" {
  type    = "string"
  default = "DefaultNSGId"
}

# NIC Configuration Name
variable "NICConfigName" {
  type    = "string"
  default = "DefaultNICName"
}

# Subnet ID
variable "SubnetId" {
  type    = "string"
  default = "SubnetId"
}

# Private IP Address Allocation
variable "PrivateIPAllocation" {
  type    = "string"
  default = "dynamic"
}

# Public IP ID
variable "PublicIPId" {
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

##################################################
### Resource 
##################################################

# Create Network Interface
resource "azurerm_network_interface" "Terra-NetworkInterface" {
  name                      = "${var.NetworkInterfaceName}"
  location                  = "${var.AzureRegion}"
  resource_group_name       = "${var.RGName}"
  network_security_group_id = "${var.NSGId}"

  ip_configuration {
    name                          = "${var.NICName}"
    subnet_id                     = "${var.SubnetId}"
    private_ip_address_allocation = "${var.PrivateIPAllocation}"
    public_ip_address_id          = "${var.PublicIPId}"
  }

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

##################################################
### Outputs
##################################################

output "Name" {
  value = "${azurerm_network_interface.Terra-NetworkInterface.name}"
}

output "Id" {
  value = "${azurerm_network_interface.Terra-NetworkInterface.id}"
}

output "PrivateIP" {
  value = "${azurerm_network_interface.Terra-NetworkInterface.private_ip_address}"
}

output "Mac" {
  value = "${azurerm_network_interface.Terra-NetworkInterface.mac_address}"
}
