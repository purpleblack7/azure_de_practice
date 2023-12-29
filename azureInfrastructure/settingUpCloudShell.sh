## This script is designed to be run in the Azure CLI using Bash. 
## This section involves setting up Terraform in the CLI and restricting its permissions. 
## Although Terraform comes with CLI, it is very outdated. Section 1 deals with updating it to the latest version at the time of coding.

# Updating Terraform
#---------------------
curl -O https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_386.zip
unzip terraform_1.6.6_linux_386.zip 

## Moving the files to a bin folder so that Cloud shell runs it every time it starts
mkdir bin
mv terraform bin/

### Restart the shell now


# Authenticate to Azure 
# -----------------------
## This step is so that Terraform has access to objects in the Microsoft Account

az login
## A new window will open asking you for a password. The password appears in the CloudShell

## Command to show all subscriptions for the account
az account list --query "[?user.name=='<microsoft_account_email>'].{Name:name, ID:id, Default:isDefault}" --output Table

## To set a specific subscription
az account set --subscription "<subscription_id_or_subscription_name>"

# Creating a Service Principal
az ad sp create-for-rbac --name <service_principal_name> --role Contributor --scopes /subscriptions/<subscription_id>

# Configuring credentials in environment variables
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"

## Executing the bashrc script
. ~/.bashrc

## Verification
printenv | grep ^ARM*