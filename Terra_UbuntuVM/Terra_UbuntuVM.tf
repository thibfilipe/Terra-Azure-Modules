######################################################################
# Module Ubuntu VM
######################################################################

### Variables

# VM Name
variable "VMName" {
  type    = "string"
  default = "DefaultVMName"
}

# Azure Region
variable "AzureRegion" {
  type    = "string"
  default = "Westeurope"
}

# Resource Group Name
variable "RGName" {
  type    = "string"
  default = "DefaultRGName"
}

# Network Interface ID(s)
variable "NICId" {
  type = "list"
}

# VM Size
variable "VMSize" {
  type    = "string"
  default = "Standard_D1_v2"
}

### Storage OS Disk

# VM OS Disk Name
variable "VMOSDiskName" {
  type    = "string"
  default = "DefaultVMOSDiskName"
}

# OS Disk Caching
variable "VMOSDiskCaching" {
  type    = "string"
  default = "ReadWrite"
}

# OS Disk Creation Option
variable "VMOSDiskCreationOption" {
  type    = "string"
  default = "FromImage"
}

# OS Managed Disk Type
variable "VMOSManagedDiskType" {
  type    = "string"
  default = "Standard_LRS"
}

### Storage Image References

# Storage Image Publisher
variable "StorageImagePublisher" {
  type    = "string"
  default = "Canonical"
}

# Storage Image Offer
variable "StorageImageOffer" {
  type    = "string"
  default = "UbuntuServer"
}

# Storage Image SKU
variable "StorageImageSKU" {
  type    = "string"
  default = "16.04.0-LTS"
}

# Storage Image Version
variable "StorageImageVersion" {
  type    = "string"
  default = "latest"
}

### OS Profile

# OS Admin Username
variable "VMAdminUsername" {
  type    = "string"
  default = "userssh"
}

# OS Admin Password
variable "VMAdminPassword" {
  type    = "string"
  default = "Password123!"
}

### Boot Diagnostics

# Storage URI
variable "PrimaryBlobEndpoint" {
  type = "string"
}

### Tags

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

# Create Ubuntu VM
resource "azurerm_virtual_machine" "Terra-UbuntuVM" {
  name                  = "${var.VMName}"
  location              = "${var.AzureRegion}"
  resource_group_name   = "${var.RGName}"
  network_interface_ids = ["${var.NICId}"]
  vm_size               = "${var.VMSize}"

  storage_os_disk {
    name              = "${var.VMOSDiskName}"
    caching           = "${var.VMOSDiskCaching}"
    create_option     = "${var.VMOSDiskCreationOption}"
    managed_disk_type = "${var.VMOSManagedDiskType}"
  }

  storage_image_reference {
    publisher = "${var.StorageImagePublisher}"
    offer     = "${var.StorageImageOffer}"
    sku       = "${var.StorageImageSKU}"
    version   = "${var.StorageImageVersion}"
  }

  os_profile {
    computer_name  = "${var.VMName}"
    admin_username = "${var.VMAdminUsername}"
    admin_password = "${var.VMAdminPassword}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${var.PrimaryBlobEndpoint}"
  }

  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

### Outputs

output "Name" {
  value = "${azurerm_virtual_machine.Terra-UbuntuVM.name}"
}

output "Id" {
  value = "${azurerm_virtual_machine.Terra-UbuntuVM.id}"
}
