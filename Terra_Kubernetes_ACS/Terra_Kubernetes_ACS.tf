######################################################################
# Module Kubernetes Cluster with ACS 
######################################################################

##################################################
### Variables
##################################################

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Kubernetes Region
variable "KubernetesLocation" {
  type    = "string"
  default = "Westeurope"
}

# Kubernetes Cluster Name
variable "KubernetesName" {
  type    = "string"
  default = "terrakubernetes"
}


variable "APDNSPrefix" {
  type    = "string"
  default = "terrakubeap"
}

#########################
## Master Pool Profile
#########################

# Master Pool DNS Prefix
variable "MPDNSPrefix" {
  type    = "string"
  default = "terrakubemp"
}

# Master Pool Count
variable "MPCount" {
  type    = "string"
  default = "1"
}

#########################
## Linux Profile
#########################

# Admin Username
variable "AdminUsername" {
  type    = "string"
  default = "useradmin"
}

# SSH Key
variable "SSHkey" {
  type    = "string"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqqu1+zvLl/YVOp69FWTREVzCRwIPZh17SL3EF/UIUIhnvmi1u7YG5ryunXcGsXxA5MiSHpeNqAqJnOdVM+kC940SsQoCD9DhOU8DpbeYKsPbDjADCROD1Tx9UsO0bqrb8iBqfyH9Ag0yqQ680EBgRXMw3WRVxQCLYzjjVNNpQs49ZCuOhHLDF2P5KlsV2ZX8gVwOScz7SY0JMEp0SQrpY4TBDGjr9ANmk/Rt77cCOFL+/mVnPIp/zBmchWfS+GvbrSt4ChBKNWvjKlCNUKLqO4XmXmhSbYTwOdipUM1LxC3Mcy4v/LE89hvjsakhLFuvQ3ER8sOjWiZUUc353U5x/ tfilipe@devoteam@FRL0449"
}

#########################
## Agent Pool Profile
#########################

# Agent Pool Name
variable "APName" {
  type    = "string"
  default = "apdefault"
}

# Agent Pool Count
variable "APCount" {
  type    = "string"
  default = "1"
}

# Agent Pool VM size
variable "APVMSize" {
  type    = "string"
  default = "Standard_D2s_v3"
}

#########################
#########################

# Client ID
variable "ClientID" {
  type    = "string"
}

# Client Secret
variable "ClientSecret" {
  type    = "string"
}

# Environement Tag
variable "EnvironmentTag" {
  type    = "string"
  default = "TDF Kubernetes Test"
}

##################################################
### Resource
##################################################

resource "azurerm_container_service" "Terra-Kubernetes-ACS" {
  name                   = "${var.KubernetesName}"
  location               = "${var.KubernetesLocation}"
  resource_group_name    = "${var.RGName}"
  orchestration_platform = "Kubernetes"

  master_profile {
    count      = 1
    dns_prefix = "${var.MPDNSPrefix}"
  }

  linux_profile {
    admin_username = "${var.AdminUsername}"

    ssh_key {
      key_data = "${var.SSHkey}"
    }
  }

  agent_pool_profile {
    name       = "${var.APName}"
    count      = "${var.APCount}"
    dns_prefix = "${var.APDNSPrefix}"
    vm_size    = "${var.APVMSize}"
  }

  service_principal {
    client_id     = "${var.ClientID}"
    client_secret = "${var.ClientSecret}"
  }

  diagnostics_profile {
    enabled = false
  }

  tags {
    Environment = "${var.EnvironmentTag}"
  }
}

##################################################
### Outputs
##################################################
output "id" {
  value = "${azurerm_container_service.Terra-Kubernetes-ACS.id}"
}

output "masterprofile_fqdn" {
  value = "${azurerm_container_service.Terra-Kubernetes-ACS.master_profile.fqdn}"
}

output "agentpoolprofile_fqdn" {
  value = "${azurerm_container_service.Terra-Kubernetes-ACS.agent_pool_profile.fqdn}"
}

output "diagnosticsprofilestorage_uri" {
  value = "${azurerm_container_service.Terra-Kubernetes-ACS.diagnostics_profile.storage_uri}"
}
