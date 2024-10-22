variable "vpc_id" {
  description = "The VPC ID where the EC2 instance will be created."
  type        = string
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

variable "key_name" {
  description = "The name of the key pair to use for SSH access."
  type        = string
}

variable "ssh_ip" {
  description = "Your public IP address for SSH access."
  type        = string
}
