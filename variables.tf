# Variable: location (default Azure region)
# 변수: location (Azure 리소스 기본 리전)
variable "location" {
  type        = string
  description = "azure resources location"  # Azure 리소스가 생성될 위치
  default     = "Korea Central"             # 기본값: Korea Central 리전
}

# Variable: product_name (used as prefix for resources)
# 변수: product_name (모든 리소스 이름/태그의 접두사로 사용)
variable "product_name" {
  type     = string
  nullable = false
  # description = "(Mandatory) Project/Application name. e.g WebApp-net \nThis will be used as prefix for all resources created."
  description = "(필수) 프로젝트/애플리케이션 이름. 예: WebApp \n 이 이름은 생성되는 모든 리소스의 이름 태그로 사용됩니다."
}

# Variable: vnets (map of VNets to create)
# 변수: vnets (생성할 VNET들의 맵 정의)
variable "vnets" {
  description = "Map of vnets to create" # 생성할 VNET 정의
  type = map(object({
    name          = string              # VNET 이름
    address_space = string              # VNET 주소 공간(CIDR)
  }))

  # 기본값: hub, prod, staging, dev VNET CIDR 정의
  default = {
    spoke1 = { name = "hub",     address_space = "10.0.0.0/20" },
    spoke2 = { name = "prod",    address_space = "10.1.0.0/16" },
    spoke3 = { name = "staging", address_space = "10.2.0.0/16" },
    spoke4 = { name = "dev",     address_space = "10.3.0.0/16" }
  }
}

# Locals: subnet definitions for each VNET
# 로컬 변수: 각 VNET별 Subnet 정의
locals {
  # Hub VNET 서브넷 정의
  subnets_hub = tomap ({
    "Management-Subnet" = {
      address_prefixes = ["10.0.1.0/24"]     # 관리용 서브넷
    },
    "Gateway-Subnet" = {
      address_prefixes = ["10.0.15.224/27"]  # 게이트웨이 서브넷
    },
    "Shared-Subnet" = {
      address_prefixes = ["10.0.4.0/22"]     # 공유 서비스 서브넷
    },
    "AzureFirewall-Subnet" = {
      address_prefixes = ["10.0.15.0/26"]    # Azure Firewall 전용 서브넷
    } 
  })

  # Dev VNET 서브넷 정의
  subnets_dev = tomap ({
    "default" = {
      address_prefixes = ["10.3.1.0/24"]     # 기본 서브넷
    }
  })

  # Prod VNET 서브넷 정의
  subnets_prod = tomap ({
    "default" = {
      address_prefixes = ["10.1.1.0/24"]     # 기본 서브넷
    }
  })

  # Staging VNET 서브넷 정의
  subnets_staging = tomap ({
    "default" = {
      address_prefixes = ["10.2.1.0/24"]     # 기본 서브넷
    }
  })
}
