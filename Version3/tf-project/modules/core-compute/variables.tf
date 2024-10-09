# modules/core-compute/variables.tf
variable "region" {
  description = "Région AWS"
  type        = string
}

variable "vpc_name" {
  description = "Nom du VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR du VPC"
  type        = string
}

variable "subnet_count" {
  description = "Nombre de subnets publics et privés"
  type        = number
}

variable "enable_dns_support" {
  description = "Activer le support DNS dans le VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Activer les noms DNS dans le VPC"
  type        = bool
  default     = true
}
