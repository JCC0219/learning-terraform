variable "filename_1" {
  type = string
  description = "Name of file 1"
  default = "file1.txt"
}

variable "filename_2" {
  type = string
  description = "Name of file 2"
  default = "file2.txt"
}

variable "file1_content" {
  type = string
  description = "Content of file 1"
  default = "Hello from file 1"
}

variable "file2_content" {
  type = string
  description = "Content of file 2"
  default = "Hello from file 2"
}