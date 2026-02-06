#simple

resource "local_file" "tf_example1" {
  #   filename = "01_basics/example1.txt"
  #   filename = "${path.module}/example1.txt"
  filename = "C:/Users/jingc/Desktop/repo/learning-terraform/01_basics/example1.txt"
  #   content = "This is a simple example of a local file resource."
  content = "Updated example1.txt"

}

resource "local_file" "tf_count" {
  count = 3
  filename = "${path.module}/count-${count.index}.txt"
  content = "This is a simple example of a local file resource. ${count.index}"
}

resource "local_sensitive_file" "tf_example2" {
  filename = "${path.module}/sensitive.txt"
  content = "This is a sensitive example of a local file resource."
}
