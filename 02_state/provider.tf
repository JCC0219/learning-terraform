terraform {
backend "local" {
  path = "C:/Users/jingc/Desktop/repo/learning-terraform/02_state/state-file/state-file.tfstate"
}
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.6.2"
    }
  }
}

provider "local" {
  # Configuration options
}