variable "location" {
  type        = string
  description = "Azure region for all resources"
  default     = "Korea Central"
}

variable "product_name" {
  type        = string
  description = "(Mandatory) Project/Application name used in resource names"
  nullable    = false
}

# Define VNets and their subnets
variable "vnets" {
  description = "VNETs to create with their subnets"
  type = map(object({
    name           = string
    address_space  = list(string)
    subnets        = map(object({
      address_prefixes = list(string)
    }))
  }))

  # Example defaults (adjust or override via tfvars)
  default = {
    hub = {
      name          = "hub"
      address_space = ["10.3.0.0/16"]
      subnets = {
        default = { address_prefixes = ["10.3.1.0/24"] }
      }
    }
    prod = {
      name          = "prod"
      address_space = ["10.1.0.0/16"]
      subnets = {
        default = { address_prefixes = ["10.1.1.0/24"] }
      }
    }
    staging = {
      name          = "staging"
      address_space = ["10.2.0.0/16"]
      subnets = {
        default = { address_prefixes = ["10.2.1.0/24"] }
      }
    }
  }
}
