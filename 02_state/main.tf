resource "local_file" "example1" {
  filename = "${path.module}/example1.txt"
  content = "This is demo example1.txt"
}

resource "local_file" "example2" {
  filename = "${path.module}/example2.txt"
  content = "This is demo example2.txt"
}

resource "local_sensitive_file" "sensitive" {
  filename = "${path.module}/sensitive.txt"
  content = "This is demo sensitive.txt"
}