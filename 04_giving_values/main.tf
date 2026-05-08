terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.6.2"
    }
  }
}


resource "local_file" "example1" {
  content  = "foo!"
  filename = "${path.module}/${var.filename}.txt"
}

//doing tf plan through -var
//terraform plan -var="filename=test"

//doing tf plan through -var-file when the default tfvars name not terraform.tfvars
//terraform plan -var-file="variables.tf"

//use TF_VAR for passing value, for example: TF_VAR_filename=test terraform plan