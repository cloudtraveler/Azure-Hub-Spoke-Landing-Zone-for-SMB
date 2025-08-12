terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Authentication is expected via Azure CLI (az login) or ARM_* environment variables.
  # If using a service principal, set ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID, and ARM_SUBSCRIPTION_ID.

}
ye