######################################################################
# Module Azure Data Lake Store
######################################################################

### Variables

# Data Lake Store Name (Lowercase/Numbers)
variable "DataLakeName" {
  type    = "string"
  default = "defaultdatalakename"
}

# Data Lake Loaction
variable "DataLakeLocation" {
  type    = "string"
  default = "Westeurope"
}

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Encryption Type
variable "EncryptionType" {
  type    = "string"
  default = "UserManaged"
}

# Key Vault ID (Output module Terra_KeyVault -> {module.Terra_KeyVault.Id})
variable "KeyVaultID" {
  type = "string"
}

# Key Name (Output module Terra_KeyVaultKey)
variable "KeyName" {
  type = "string"
}

# Key Version (Output module Terra_KeyVaultKey)
variable "KeyVersion" {
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

# Create Data Lake Store

resource "azurerm_data_lake_store" "Terra-DataLakeStore" {
  name                = "${var.DataLakeName}"
  resource_group_name = "${var.RGName}"
  location            = "${var.DataLakeLocation}"


  encrytpion {
    type         = "${var.EncryptionType}"
    key_vault_id = "${var.KeyVaultID}"
    key_name     = "${var.KeyName}"
    key_version  = "${var.KeyVersion}"
  }
}

### Outputs

output "Name" {
  value = "${azurerm_data_lake_store.Terra-DataLakeStore.name}"
}

output "Id" {
  value = "${azurerm_data_lake_store.Terra-DataLakeStore.id}"
}

output "RGName" {
  value = "${azurerm_data_lake_store.Terra-DataLakeStore.resource_group_name}"
}

output "RGLocation" {
  value = "${azurerm_data_lake_store.Terra-DataLakeStore.location}"
}
