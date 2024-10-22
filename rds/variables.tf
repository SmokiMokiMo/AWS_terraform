variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_id_1" {
  description = "The ID of the private subnet"
  type        = string
}

variable "private_subnet_id_2" {
  description = "The ID of the private subnet"
  type        = string
}

variable "db_username" {
  description = "The username for the RDS database."
  type        = string  
}

variable "db_password" {
  description = "The password for the RDS database."
  type        = string
}

variable "ec2_sg_id" {
  description = "The security group ID for EC2 instances"
}