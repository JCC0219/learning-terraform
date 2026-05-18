output "file1_content" {
  description = "Content of file 1"
  value       = var.file1_content
}

output "file2_content" {
  description = "Content of file 2"
  value       = var.file2_content
}

output "file1_path" {
  description = "Path to file 1"
  value       = local_file.file1.filename
}

output "file2_path" {
  description = "Path to file 2"
  value       = local_file.file2.filename
}
