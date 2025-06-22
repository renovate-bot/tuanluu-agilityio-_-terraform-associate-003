terraform {
  /* Uncomment this block to use Terraform Cloud for this tutorial
  cloud {
    organization = "organization-name"
    workspaces {
      name = "learn-terraform-provider-versioning"
    }
  }
  */

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.5.0"
    }
  }

  required_version = "~> 1.2"
}