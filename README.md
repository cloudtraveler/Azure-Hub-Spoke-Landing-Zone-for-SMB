Azure Hub–Spoke Landing Zone for SMB (Terraform)

중소·중견 조직(SMB)을 위한 간단하고 견고한 Azure Hub–Spoke 네트워크 레퍼런스입니다.
허브/스포크 VNet, 서브넷, NSG, NSG 연동, 양방향 VNet 피어링을 Terraform으로 구성합니다.

목표: 엔터프라이즈급 LZ의 핵심 이점(격리/확장/공유 서비스)을 유지하면서도, 단순한 변수만으로 빠르게 배포할 수 있도록 설계

                        +----------------------------+
                        |         Hub VNet           |
                        |  (공유 서비스/보안/Egress)  |
                        |                            |
            Internet -> | AzureFirewallSubnet        |
                        | GatewaySubnet (VPN/ER)     |
                        | Management-Subnet          |
                        | Shared-Subnet              |
                        +-------------+--------------+
                                      | Peering (bi-directional)
                                      |
               +----------------------+----------------------+
               |                      |                      |
        +------+-------+        +-----+-------+        +-----+-------+
        | Spoke (prod) |        | Spoke (stg) |        | Spoke (dev) |
        | default snet |        | default snet|        | default snet|
        +--------------+        +-------------+        +-------------+


빠른 시작

1. 로그인 및 구독 선택

   az login

   az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"


2. Terraform 초기화/검증:
   
   terraform init

   terraform plan -var 'product_name=myapp'


5. 적용:

   terraform apply -var 'product_name=myapp'
