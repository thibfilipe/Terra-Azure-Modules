#################################################################
# This file contains all secret that are not to be exposed in Git
#################################################################
#################################################################
# Variables for Azure Registration
#################################################################

variable "AzureSubscriptionID" {
  type    = "string"
  default = ""
}

variable "AzureClientID" {
  type    = "string"
  default = ""
}

variable "AzureClientSecret" {
  type    = "string"
  default = ""
}

variable "AzureTenantID" {
  type    = "string"
  default = ""
}

# Client ID = Application ID
# Connect-AzureRmAccount (Subscription ID & Tenant ID)

