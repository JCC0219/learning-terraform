terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.45.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
#   shared_credentials_files = [
#     "~/.aws/credentials"
#   ]
#   profile="terraform-vscode"
}