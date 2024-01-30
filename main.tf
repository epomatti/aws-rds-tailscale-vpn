terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  workload = "tailscale"
}

module "kms" {
  source = "./modules/kms"
}

module "vpc" {
  source   = "./modules/vpc"
  region   = var.aws_region
  workload = local.workload
}

module "database" {
  source      = "./modules/rds"
  workload    = local.workload
  kms_key_arn = module.kms.kms_key_arn

  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.private_subnets
  availability_zones = module.vpc.availability_zones

  instance_class = var.rds_instance_class
}

module "tailscale" {
  source        = "./modules/tailscale"
  workload      = local.workload
  vpc_id        = module.vpc.vpc_id
  subnet        = module.vpc.subnet_public1_id
  instance_type = var.instance_type
  ami           = var.ami
  userdata      = var.userdata
}
