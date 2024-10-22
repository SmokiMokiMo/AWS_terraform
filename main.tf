terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72"
    }
  }
}

provider "aws" {
  region = var.region 
}

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source            = "./ec2"
  vpc_id            = module.vpc.vpc_id 
  private_subnet_id_1 = module.vpc.private_subnet_id_1 
  private_subnet_id_2 = module.vpc.private_subnet_id_2 
  public_subnet_id_1  = module.vpc.public_subnet_id_1  
  public_subnet_id_2  = module.vpc.public_subnet_id_2  
  key_name          = var.key_name
  ssh_ip            = var.ssh_ip
}

module "rds" {
  source            = "./rds"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id_1 = module.vpc.private_subnet_id_1
  private_subnet_id_2 = module.vpc.private_subnet_id_2
  db_username       = var.db_username
  db_password       = var.db_password
  ec2_sg_id         = module.ec2.ec2_sg_id
}

module "elasticache" {
  source            = "./elasticache"
  vpc_id            = module.vpc.vpc_id
  private_subnet_id_1  = module.vpc.private_subnet_id_1
  private_subnet_id_2  = module.vpc.private_subnet_id_2
  public_subnet_id_1   = module.vpc.public_subnet_id_1
  public_subnet_id_2   = module.vpc.public_subnet_id_2

}