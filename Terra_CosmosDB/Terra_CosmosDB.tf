######################################################################
# Module Cosmos DB
######################################################################

##################################################
### Variables
##################################################

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

# Cosmos DB Name
variable "CosmosDBName" {
  type    = "string"
  default = "DefaultCosmosDBName"
}

# Cosmos DB Offer type
variable "CosmosDBOfferType" {
  type    = "string"
  default = "Standard"
}

# Consistency policy
variable "CosmosDBConsistencyPolicy" {
  type    = "string"
  default = "BoundedStaleness"
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

# Generate Random string
resource "random_string" "CosmosDBprefix" {
  length  = 4
  special = false
  upper   = false
  lower   = false
}

# Create Comsos DB
resource "azurerm_cosmosdb_account" "Terra-CosmosDB" {
  name                = "${random_string.CosmosDBprefix.result}${var.CosmosDBName}"
  location            = "${var.AzureRegion}"
  resource_group_name = "${var.RGName}"
  offer_type          = "${var.CosmosDBOfferType}"

  consistency_policy {
    consistency_level = "${var.CosmosDBConsistencyPolicy}"
  }

  geo_location {
    location          = "${var.AzureRegion}"
    failover_priority = 0
  }

  /*
  geo_location {
    location = "East US"
    failover_priority = 1
  }
  */

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

##################################################
### Outputs
##################################################

output "Name" {
  value = "${azurerm_cosmosdb_account.Terra-CosmosDB.name}"
}

output "Id" {
  value = "${azurerm_cosmosdb_account.Terra-CosmosDB.id}"
}

output "Location" {
  value = "${azurerm_cosmosdb_account.Terra-CosmosDB.location}"
}

output "EP" {
  value = "${azurerm_cosmosdb_account.TerraCosmosDB.endpoint}"
}

output "REP" {
  value = "${azurerm_cosmosdb_account.TerraCosmosDB.read_endpoints}"
}

output "WEP" {
  value = "${azurerm_cosmosdb_account.TerraCosmosDB.write_endpoints}"
}

output "PMK" {
  value     = "${azurerm_cosmosdb_account.TerraCosmosDB.primary_master_key}"
  sensitive = true
}

output "SMK" {
  value     = "${azurerm_cosmosdb_account.TerraCosmosDB.secondary_master_key}"
  sensitive = true
}

output "PRMK" {
  value     = "${azurerm_cosmosdb_account.TerraCosmosDB.primary_readonly_master_key}"
  sensitive = true
}

output "SRMK" {
  value     = "${azurerm_cosmosdb_account.TerraCosmosDB.secondary_readonly_master_key}"
  sensitive = true
}

output "CSTR" {
  value = "${azurerm_cosmosdb_account.TerraCosmosDB.connection_strings}"
}
