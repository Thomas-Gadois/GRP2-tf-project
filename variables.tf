#Variables.tf
variable "region" {
  description = "Région AWS"
  type        = string
  default     = "us-west-1"
}

variable "vpc_name" {
  description = "Nom du vpc"
  type        = string
  default     = "GRP2-VPC"
}

variable "vpc_cidr" {
  description = "CIDR du VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "subnet_count" {
  description = "Nombre de subnets publics et privés"
  type        = number
  default     = 2
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

variable "cluster_name" {
  description = "Nom du cluster EKS"
  type        = string
  default     = "GRP2-eks-cluster"
}