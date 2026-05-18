terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.9.0"
    }
  }
}


module "file_creator" {
  source        = "./file_creator"
  filename_1    = "my_first_file.txt"
  file1_content = "from file1"
  filename_2    = "my_second_file.txt"
  file2_content = "from file2"
}

output "file_paths" {
  value = [
    "Hello", module.file_creator.file1_path,
    module.file_creator.file2_path
  ]
}