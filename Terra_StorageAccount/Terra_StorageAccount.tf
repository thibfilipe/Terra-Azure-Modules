######################################################################
# Module Storage Account
######################################################################

##################################################
### Variables
##################################################

# Storage Account Name
variable "StorageAccountName" {
  type    = "string"
  default = "storageaccount"
}

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Azure Region
variable "StorageAcountLocation" {
  type    = "string"
  default = "Westeurope"
}

# Storage Account Tier
variable "StorageAccountTier" {
  type    = "string"
  default = "Standard"
}

# Storage Account Replication Type (LRS, GRS, RAGRS or ZRS)
variable "StorageReplicationType" {
  type    = "string"
  default = "LRS"
}

# Storage Account Type
variable "StorageAccountType" {
  type    = "string"
  default = "StorageV2"
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
### Ressource
##################################################

# Generate Random string
resource "random_string" "StorageAccountprefix" {
  length  = 5
  special = false
  upper   = false
}

# Create Storage Account
resource "azurerm_storage_account" "Terra-StorageAccount" {
  name                     = "${random_string.StorageAccountprefix.result}${var.StorageAccountName}"
  resource_group_name      = "${var.RGName}"
  location                 = "${var.StorageAcountLocation}"
  account_tier             = "${var.StorageAccountTier}"
  account_replication_type = "${var.StorageReplicationType}"
  account_kind             = "${var.StorageAccountType}"

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

##################################################
### Outputs
##################################################

output "Name" {
  value = "${azurerm_storage_account.Terra-StorageAccount.name}"
}

output "Id" {
  value = "${azurerm_storage_account.Terra-StorageAccount.id}"
}

output "PrimaryBlobEP" {
  value = "${azurerm_storage_account.Terra-StorageAccount.primary_blob_endpoint}"
}

output "PrimaryQueueEP" {
  value = "${azurerm_storage_account.Terra-StorageAccount.primary_queue_endpoint}"
}

output "PrimaryTableEP" {
  value = "${azurerm_storage_account.Terra-StorageAccount.primary_table_endpoint}"
}

output "PrimaryFileEP" {
  value = "${azurerm_storage_account.Terra-StorageAccount.primary_file_endpoint}"
}

output "PrimaryAccessKey" {
  value = "${azurerm_storage_account.Terra-StorageAccount.primary_access_key}"
}

output "SecondaryAccessKey" {
  value = "${azurerm_storage_account.Terra-StorageAccount.secondary_access_key}"
}

output "ConnectionURI" {
  value = "${azurerm_storage_account.Terra-StorageAccount.primary_blob_connection_string}"
}
