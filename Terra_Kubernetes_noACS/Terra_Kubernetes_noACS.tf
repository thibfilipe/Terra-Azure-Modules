######################################################################
# Module Kubernetes Cluster without ACS 
######################################################################

# WARNING : The Kubernetes cluster is deployed in a different Resource Group!

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

# DNS Prefix
variable "DNSPrefix" {
  type    = "string"
  default = "terrakubeacctest"
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
  default = "Standard_D1_v2"
}

# Agent Pool OS Type
variable "APOSType" {
  type    = "string"
  default = "Linux"
}

# Agent Pool OS Disk Size
variable "APOSDiskSize" {
  type    = "string"
  default = "30"
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

resource "azurerm_kubernetes_cluster" "Terra-Kubernetes-noACS" {
  name                = "${var.KubernetesName}"
  location            = "${var.KubernetesLocation}"
  resource_group_name = "${var.RGName}"
  dns_prefix          = "${var.DNSPrefix}"

  linux_profile {
    admin_username = "${var.AdminUsername}"

    ssh_key {
      key_data = "${var.SSHkey}"
    }
  }

  agent_pool_profile {
    name            = "${var.APName}"
    count           = "${var.APCount}"
    vm_size         = "${var.APVMSize}"
    os_type         = "${var.APOSType}"
    os_disk_size_gb = "${var.APOSDiskSize}"
  }

  service_principal {
    client_id     = "${var.ClientID}"
    client_secret = "${var.ClientSecret}"
  }

  tags {
    Environment = "${var.EnvironmentTag}"
  }
}

##################################################
### Outputs
##################################################

output "id" {
    value = "${azurerm_kubernetes_cluster.Terra-Kubernetes-noACS.id}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.Terra-Kubernetes-noACS.kube_config_raw}"
}

output "client_key" {
  value = "${azurerm_kubernetes_cluster.Terra-Kubernetes-noACS.kube_config.0.client_key}"
}

output "client_certificate" {
  value = "${azurerm_kubernetes_cluster.Terra-Kubernetes-noACS.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.Terra-Kubernetes-noACS.kube_config.0.cluster_ca_certificate}"
}

output "host" {
  value = "${azurerm_kubernetes_cluster.Terra-Kubernetes-noACS.kube_config.0.host}"
}