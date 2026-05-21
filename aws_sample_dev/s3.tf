resource "aws_s3_bucket" "tf_s3_bucket" {
  bucket = "nodejs-bucket0123"

  tags = {
    Name        = "Nodejs terraform bucket"
    Environment = "Dev"
  }
}


resource "aws_s3_object" "tf_s3_object" {
  bucket = aws_s3_bucket.tf_s3_bucket.bucket //reference the bucket created above
  for_each = fileset("\\images","**")
  key    = "images/${each.key}"
  source = "\\images\"${each.key}"


#  sample advanced use and each.key and each.value
# each.value and key will be same when we use set instead of map (in variable type)
# locals {
#   subnets = {
#     "public_a" = { cidr = "10.0.1.0/24", zone = "us-east-2a" }
#     "public_b" = { cidr = "10.0.2.0/24", zone = "us-east-2b" }
#   }
# }

# resource "aws_subnet" "main" {
#   for_each = local.subnets

#   # each.key       = "public_a"
#   # each.value.cidr = "10.0.1.0/24"
#   # each.value.zone = "us-east-2a"

#   vpc_id            = aws_vpc.main.id
#   cidr_block        = each.value.cidr
#   availability_zone = each.value.zone

#   tags = {
#     Name = each.key
#   }
# }
}