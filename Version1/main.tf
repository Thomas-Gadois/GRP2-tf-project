#Main.tf
# Configuration du provider AWS
provider "aws" {
  region = var.region
}

# Création du VPC
resource "aws_vpc" "vpc_name" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = "${var.vpc_name}"
  }
}
