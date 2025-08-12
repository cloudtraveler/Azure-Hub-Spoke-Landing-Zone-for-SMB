# Azure-Hub-Spoke-Landing-Zone-for-SMB
Azure Hub &amp; Spoke Landing Zone for Small to Medium Businesses

빠른 실행 가이드

1. Azure 로그인:
   
az login

az account set --subscription "<YOUR_SUBSCRIPTION_ID>"


2. Terraform 초기화/검증:
   
terraform init

terraform plan -var 'product_name=myapp'


3. 적용:

terraform apply -var 'product_name=myapp'
