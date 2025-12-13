terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../modules/vpc"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  name               = var.name
}

module "security_group" {
  source = "../modules/security_group"

  vpc_id = module.vpc.vpc_id
  name   = var.name
}

module "ec2" {
  source = "../modules/ec2"

  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = module.vpc.public_subnet_id
  vpc_security_group_ids = [module.security_group.sg_id]
  tags                   = var.tags
}

module "s3" {
  source = "../modules/s3"

  bucket_name       = var.bucket_name
  enable_versioning = var.enable_versioning
  acl               = var.acl
  tags              = var.tags
}

