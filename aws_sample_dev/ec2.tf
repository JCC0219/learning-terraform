# 1. ec2 instanfe resource
# 2. new security group
#       - 22 (ssh)
#       - 80 (http)
#       - 443 (https)
#       - 3000 (nodejs)
# 3.  


resource "aws_instance" "tf_ec2_instance" {
  ami                         = "ami-0e86000a99b6083f1" # ubuntu 24.04 image
  instance_type               = "t3.micro"              # t3.micro free-tier eligible
  associate_public_ip_address = true                    # give public ip
  key_name                    = "key-for-dev"           # you need to create this key pair in AWS, place the private key in ~/.ssh/ as key-for-dev.pem

  # attach the security group to the instance
  # vpc_security_group_ids = [aws_security_group.tf_ec2_sg.id]
  vpc_security_group_ids = [module.tf_module_ec2_sg.security_group_id]
  depends_on             = [aws_s3_bucket.tf_s3_bucket]

  user_data = <<-EOF
  #!/bin/bash

  #update package list
  sudo apt-get update -y
  
  #install nodejs and npm
  sudo apt-get install -y nodejs
  sudo apt-get install -y npm

  #install pm2 globally
  sudo npm install -g pm2

  #git clone repo
  sudo git clone https://github.com/verma-kunal/nodejs-mysql.git /home/ubuntu/nodejs-mysql
  cd /home/ubuntu/nodejs-mysql

  #edit env vars
  echo "DB_USER=${var.db_user}" > .env
  echo "DB_HOST=${var.db_host}" >> .env
  echo "DB_PASS=${var.db_pass}" >> .env
  echo "DB_NAME=${var.db_name}" >> .env
  echo "DB_PORT=${var.db_port}" >> .env
  
  #start server
  npm install
  pm2 start app.js --name nodejs-server
  pm2 save

  EOF

  user_data_replace_on_change = true

  tags = {
    Name = "nodejs-server"
  }
}

# 2. new security group
# resource "aws_security_group" "tf_ec2_sg" {
#   name        = "nodejs-server-sg"
#   description = "Security group for Terraform"
#   vpc_id      = "vpc-004f45971f8f9711a" #Default VPC

#   tags = {
#     Name = "nodejs-server"
#   }

#   ingress {
#     description = "Allow HTTPS traffic"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Allow Nodejs traffic"
#     from_port   = 3000
#     to_port     = 3000
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# #add more ingress rule
# resource "aws_security_group_rule" "tf_security_group_rule" {
#   type              = "ingress"
#   description       = "Allow SSH traffic"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.tf_ec2_sg.id
# }

#https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest
module "tf_module_ec2_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  vpc_id = "vpc-004f45971f8f9711a" #Default VPC
  name = "nodejs-server-sg"
  description = "Security group for Terraform"
  # ingress_rules = ["https-443-tcp", "ssh-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule = "ssh-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_rules = ["all-all"]

  tags = {
    Name = "nodejs-server"
  }
}

output "ec2_public_ip" {
  value = "ssh -i ~/.ssh/key-for-dev.pem ubuntu@${aws_instance.tf_ec2_instance.public_ip}"
}
