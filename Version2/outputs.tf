

output "vpc_id" {
  description = "ID du VPC "
  value       = module.core-compute.vpc_id
}

output "public_subnet_ids" {
  description = "Liste des IDs des sous-réseaux publics"
  value       = module.core-compute.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Liste des IDs des sous-réseaux privés"
  value       = module.core-compute.private_subnet_ids
}

output "nat_gateway_id" {
  description = "ID de la NAT Gateway"
  value       = module.core-compute.nat_gateway_id
}

output "internet_gateway_id" {
  description = "ID de la Internet Gateway"
  value       = module.core-compute.internet_gateway_id
}

output "public_route_table_id" {
  description = "ID de la table de routage publique"
  value       = module.core-compute.public_route_table_id
}

output "private_route_table_id" {
  description = "ID de la table de routage privée"
  value       = module.core-compute.private_route_table_id
}

output "instance_id" {
  description = "ID de l'instance EC2 créée"
  value       = module.core-compute.instance_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.core-compute.security_group_id
}