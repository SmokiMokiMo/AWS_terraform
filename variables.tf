variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-central-1" 
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "lab_8"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string  
  default     = "" 
}

variable "public_subnet_id_1" {
  description = "The ID of the public subnet"
  type        = string
  default     = ""
}

variable "public_subnet_id_2" {
  description = "The ID of the public subnet"
  type        = string
  default     = ""
}

variable "private_subnet_id_1" {
  description = "The ID of the private subnet"
  type        = string
  default     = ""
}

variable "private_subnet_id_2" {
  description = "The ID of the private subnet"
  type        = string
  default     = ""
}

variable "ssh_ip" {
  description = "Connect only from this IP"
  type = string
  default = "176.36.214.95/32"
}
variable "db_username" {
  description = "The username for the RDS database."
  type        = string
  default     = "CqkAkkyK"
}

variable "db_password" {
  description = "The password for the RDS database."
  type        = string
  default     = "8MdfYEXt8AF3L"
}