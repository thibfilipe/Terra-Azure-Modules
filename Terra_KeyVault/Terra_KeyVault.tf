######################################################################
# Module Azure Key Vault
######################################################################

##################################################
### Variables
##################################################

# Key Vault Name
variable "KeyVaultName" {
  type    = "string"
  default = "DefaultKeyVaultName"
}

# Key Vault Loaction
variable "KeyVaultLocation" {
  type    = "string"
  default = "Westeurope"
}

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Azure Tenant ID
variable "AzureTenantID" {
  type = "string"

  # AzureTenantID = "${var.AzureTenantID}" in the Main.tf (refers to Access.tf)
}

# Azure Object ID
variable "AzureObjectID" {
  type = "string"

  # AzureObjectID = "${var.AzureObjectID}" in the Main.tf (refers to Access.tf)
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

# Create Key Vault
resource "azurerm_key_vault" "Terra-KeyVault" {
  name                = "${var.KeyVaultName}"
  location            = "${var.KeyVaultLocation}"
  resource_group_name = "${var.RGName}"

  sku {
    name = "standard"
  }

  tenant_id = "${var.AzureTenantID}"

  access_policy {
    tenant_id = "${var.AzureTenantID}"
    object_id = "${var.AzureObjectID}"

    key_permissions    = ["get"]
    secret_permissions = ["get"]
  }

  enabled_for_disk_encryption = true

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

##################################################
### Outputs
##################################################
output "Name" {
  value = "${azurerm_key_vault.Terra-KeyVault.name}"
}

output "Id" {
  value = "${azurerm_key_vault.Terra-KeyVault.id}"
}

output "VaultURI" {
  value = "${azurerm_key_vault.Terra-KeyVault.vault_uri}"
}

output "RGName" {
  value = "${azurerm_key_vault.Terra-KeyVault.resource_group_name}"
}

output "RGLocation" {
  value = "${azurerm_key_vault.Terra-KeyVault.location}"
}
