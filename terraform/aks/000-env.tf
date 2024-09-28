terraform {
  backend "s3" {
    bucket = "k8gb-kcdporto-tf"
    key    = "terraformstate/azure.tfstate"
    region = "us-east-1"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.51.0"
    }
  }
}

provider "azurerm" {
  tenant_id       = "0c568ebc-c62f-4671-8c99-51ad25cb084c"
  subscription_id = "dbeda895-eaa3-4f5c-a40e-3a1a8a582130"
  resource_provider_registrations = "none"
  features {
  }
} 
