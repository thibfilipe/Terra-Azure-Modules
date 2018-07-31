############################################################
# Module Resource Group
############################################################

### Variables

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Azure Region
variable "AzureRegion" {
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

# Create Resource Group
resource "azurerm_resource_group" "Terra-RG" {
  name     = "${var.RGName}"
  location = "${var.AzureRegion}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

### Outputs

output "Name" {
  value = "${azurerm_resource_group.Terra-RG.name}"
}

output "Location" {
  value = "${azurerm_resource_group.Terra-RG.location}"
}

output "Id" {
  value = "${azurerm_resource_group.Terra-RG.id}"
}
