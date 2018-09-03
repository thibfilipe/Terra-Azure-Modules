######################################################################
# Module Container Registry (NEED a storage account to work)
######################################################################

### Variables

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Container Registry Region
variable "ContainerRegRegion" {
  type    = "string"
  default = "Westeurope"
}

# Container Registry Name
variable "ContainerRegName" {
  type    = "string"
  default = "DefaultContainerRegName"
}

# Container Registry SKU ("Classic", "Standard" or "Pemium")
variable "ContainerRegSku" {
  type    = "string"
  default = "Classic"
}

# Container Registry Storage Account ID (MUST be located to the same Region)
variable "ContainerRegStoaId" {
  type    = "string"
}

# Environement Tag
variable "EnvironmentTag" {
  type    = "string"
  default = "Environement Test"
}


### Resource

resource "azurerm_container_registry" "Terra-ContainerRegistry" {
  name                = "${var.ContainerRegName}"
  resource_group_name = "${var.RGName}"
  location            = "${var.ContainerRegRegion}"
  admin_enabled       = true                                # Optionnal, default = false
  sku                 = "${var.ContainerRegSku}"            # Optionnal
  storage_account_id  = "${var.ContainerRegStoaId}"

  tags {                                                    # Optionnal
  Environment         = "${var.EnvironmentTag}"             
  }
}

### Outputs

output "id" {
    value = "${azurerm_container_registry.Terra-ContainerRegistry.id}"
}

output "login_server" {
  value = "${azurerm_container_registry.Terra-ContainerRegistry.login_server}"
}

output "admin_username" {
  value = "${azurerm_container_registry.Terra-ContainerRegistry.admin_username}"
}

output "admin_password" {
  value = "${azurerm_container_registry.Terra-ContainerRegistry.admin_password}"
}