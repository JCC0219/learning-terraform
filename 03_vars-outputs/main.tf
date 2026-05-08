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
  filename = "${path.module}/${var.filename-1}"
  count    = var.count_num
}

#local variable
locals {
  base_path = "${path.module}/files"
}

resource "local_file" "example2" {
  content  = "foo!"
  filename = "${local.base_path}/${var.filename-2}"
}

resource "local_file" "example3" {
  content  = "foo!"
  filename = "${local.base_path}/example3.txt"
}
resource "local_file" "example4" {
  content  = "foo!"
  filename = "${local.base_path}/example4.txt"
}


locals {
  enviroment  = "dev" # dev, stage, prod
  upper_case  = upper(local.enviroment)
  config_path = "${path.module}/config/${local.upper_case}"
}

resource "local_file" "service_configs1" {
  filename = "${local.config_path}/server1.sh"
  content  = <<-EOT
  enviroment = "${local.enviroment}"
  port = 3000
  EOT
}

resource "local_file" "service_configs2" {
  filename = "${local.config_path}/server2.sh"
  content  = <<-EOT
  enviroment = "${local.enviroment}"
  port = 3000
  EOT
}

//outputs
output "filename-1" {
  value = local_file.service_configs1.filename
  # sensitive = true
}
