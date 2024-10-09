#Main.tf
# Configuration du provider AWS
provider "aws" {
  region = var.region
}

# Indiquer le bucket S3 qui doit contenir le tfstate
terraform {
  backend "s3" {
    bucket         = "grp2-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "grp2-terraform-state-lock"
    encrypt        = true
  }
}

module "core-compute" {
  source = "./modules/core-compute"

  region       = var.region
  vpc_name     = var.vpc_name
  vpc_cidr     = var.vpc_cidr
  subnet_count = var.subnet_count
}

# Exposer les ressources du module pour qu'elles soient accessibles dans d'autres fichiers
locals {
  vpc_id             = module.core-compute.vpc_id
  public_subnet_ids  = module.core-compute.public_subnet_ids
  private_subnet_ids = module.core-compute.private_subnet_ids
  security_group_id  = module.core-compute.security_group_id
}