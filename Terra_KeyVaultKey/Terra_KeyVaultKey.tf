######################################################################
# Module Azure Key for Key Vault
######################################################################

##################################################
### Variables
##################################################

# Key Vault Key Name
variable "KeyVaultKeyName" {
  type    = "string"
  default = "DefaultKeyVaultName"
}

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Key Type (could be EC (Elliptic Curve), Oct (Octet), RSA and RSA-HSM)
variable "KeyType" {
  type    = "string"
  default = "RSA"
}

# Key Vault URI (Output module Terra_KeyVault -> {module.Terra_KeyVault.VaultURI})
variable "VaultURI" {
  type = "string"
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

/*
data "azurerm_client_config" "current" {}

resource "random_id" "RandomKeyName" {
  keepers = {
    ami_id = 1
  }

  byte_length = 8
}
*/

resource "azurerm_key_vault_key" "Terra-KeyVaultKey" {
  name      = "${var.KeyVaultKeyName}"
  vault_uri = "${var.VaultURI}"
  key_type  = "${var.KeyType}"
  key_size  = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

##################################################
### Outputs
##################################################
output "Name" {
  value = "${azurerm_key_vault_key.Terra-KeyVaultKey.name}"
}

output "Id" {
  value = "${azurerm_key_vault_key.Terra-KeyVaultKey.id}"
}

output "Version" {
  value = "${azurerm_key_vault_key.Terra-KeyVaultKey.version}"
}
