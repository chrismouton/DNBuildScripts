# Requirements
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

# Open command-prompt and set Azure subscription
## 1. Login into Azure
```
az login
```

## 2. List subscriptions
```
az account list
```

## 3. Make note of your target subscription ID
```
az account set --subscription="SUBSCRIPTION_ID"
```

# Create infrastructure in Azure using Terraform
## 1. Navigate to .\Terraform\ directory
```
cd Terraform
```

## 2. Initialize Terraform
```
..\Tools\Terraform\1.1.2_amd64\terraform init
```

## 3. Validate Terraform scripts
```
..\Tools\Terraform\1.1.2_amd64\terraform validate
```

## 4. Create the Terraform plan
```
..\Tools\Terraform\1.1.2_amd64\terraform plan
```

## 5. Apply the Terraform plan
```
..\Tools\Terraform\1.1.2_amd64\terraform apply
```
