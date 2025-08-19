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
  # Azure 인증은 Azure CLI (az login) or ARM_* environment variables.
  # 필요하면 ID값 환경 설정 set ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID, and ARM_SUBSCRIPTION_ID.
  # subscription_id = " "
  # tenant_id       = " "
}
