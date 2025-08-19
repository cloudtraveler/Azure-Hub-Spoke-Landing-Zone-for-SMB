variable "location" {
  type    = string
  description = "azure resources location"
  default = "Korea Central"
}
variable "product_name" {
  type = string
  nullable = false
#  description = "(Mandatory) Project/Application name. e.g WebApp-net \nThis will be used as prefix for all resources created."
   description = "(필수) 프로젝트/애플리케이션 이름. 예: WebApp \n 이 이름은 생성되는 모든 리소스의 접두사로 사용됩니다."
 
}
variable "vnets" {
  description = "Map of vnets to create"
  type = map(object({
    name          = string
    address_space = string
  }))
  default = {
    spoke1 = { name = "hub", address_space = "10.0.0.0/20" },
    spoke2 = { name = "prod", address_space = "10.1.0.0/16" },
    spoke3 = { name = "staging", address_space = "10.2.0.0/16" },
    spoke4 = { name = "dev", address_space = "10.3.0.0/16" }
  }
}
locals {
  subnets_hub = tomap ({
    "Management-Subnet" = {
      address_prefixes = ["10.0.1.0/24"]
    },
    "Gateway-Subnet" = {
      address_prefixes = ["10.0.15.224/27"]
    },
    "Shared-Subnet" = {
      address_prefixes = ["10.0.4.0/22"]
    },
    "AzureFirewall-Subnet" = {
      address_prefixes = ["10.0.15.0/26"]
    } 
  } )
  
  
  subnets_dev = tomap ({
    "default" = {
      address_prefixes = ["10.3.1.0/24"]
    }
  } )

  subnets_prod = tomap ({
    "default" = {
      address_prefixes = ["10.1.1.0/24"]
    }
  } )

  subnets_staging = tomap ({
    "default" = {
      address_prefixes = ["10.2.1.0/24"]
    }
  } )
}
