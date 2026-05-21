# 1. rds tf resource
# 2. security group
#       -3306 allow from EC2
#       -3306 allow from RDS (Security Group ID)
#       -cidr_block => ["local ip"]
# 3. outputs

#rds resource
resource "aws_db_instance" "tf_rds_instance" {
  allocated_storage    = 10
  db_name              = "mydb"
  identifier           = "nodejs-rds-mysql"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db_user
  password             = var.db_pass
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = true

  vpc_security_group_ids = [aws_security_group.tf_rds_sg.id]

  depends_on = [aws_security_group.tf_rds_sg]
}

#security group
resource "aws_security_group" "tf_rds_sg" {
  name        = "nodejs-rds-sg"
  description = "Security group for Terraform"
  vpc_id      = "vpc-004f45971f8f9711a" #Default VPC

  tags = {
    Name = "nodejs-rds"
  }

  ingress {
    description     = "Allow MySQL traffic"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    # cidr_blocks     = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.tf_ec2_sg.id]
    security_groups = [module.tf_module_ec2_sg.security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "rds_endpoints" {
  value = aws_db_instance.tf_rds_instance.endpoint
}

output "rds_user_name" {
  value = aws_db_instance.tf_rds_instance.username
}

output "rds_db_name" {
  value = aws_db_instance.tf_rds_instance.db_name
}
