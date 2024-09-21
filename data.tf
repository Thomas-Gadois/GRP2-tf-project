#data.tf
# Récupération dynamique des zones de disponibilité (AZs)
data "aws_availability_zones" "available" {
  state = "available"
}