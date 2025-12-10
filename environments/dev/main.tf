provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  name           = "dev"
  cidr_block     = var.cidr_block
  public_subnets = var.public_subnets
  azs            = var.azs

  tags = {
    Environment = "dev"
    Owner       = "DevOps"
  }
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id = module.vpc.vpc_id
  name   = var.name
}

module "ec2" {
  source = "./modules/ec2"

  instance_type        = var.instance_type
  key_name             = var.key_name
  subnet_id            = module.vpc.public_subnet_id
  vpc_security_group_ids = [module.security_group.sg_id]

  tags = {
    Environment = "dev"
  }
}

module "s3" {
  source = "./modules/s3"

  bucket_name       = var.bucket_name
  enable_versioning = var.enable_versioning
  acl               = var.acl
  tags              = var.tags
}