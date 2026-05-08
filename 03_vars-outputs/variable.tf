variable "filename-1" {
  type        = string
  default     = "example1.txt"
  description = "this is the name of file 1"
}

variable "filename-2" {
  type        = string
  default     = "example2.txt"
  description = "this is the name of file 2"
}

variable "filename-3" {
  type        = string
  default     = "example3.txt"
  description = "this is the name of file 3"
}

variable "count_num" {
  type        = number
  default     = 1 #uncomment this for input param
  description = "this is the count number"
}
