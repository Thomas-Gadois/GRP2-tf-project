variable "region" {
  description = "La région AWS où créer le bucket"
  type        = string
  default     = "us-west-1"
}

variable "bucket_name" {
  description = "Le nom du bucket S3 pour le state Terraform"
  type        = string
  default     = "grp2-terraform-state-bucket"
}
