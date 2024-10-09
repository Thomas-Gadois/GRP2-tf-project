# modules/core-compute/outputs.tf

output "vpc_id" {
  description = "ID du VPC"
  value       = aws_vpc.vpc_name.id
}

output "public_subnet_ids" {
  description = "Liste des IDs des sous-réseaux publics"
  value       = aws_subnet.GRP2-public-subnet[*].id
}

output "private_subnet_ids" {
  description = "Liste des IDs des sous-réseaux privés"
  value       = aws_subnet.GRP2-private-subnet[*].id
}

output "nat_gateway_id" {
  description = "ID de la passerelle NAT"
  value       = aws_nat_gateway.GRP2-NAT-gateway.id
}

output "internet_gateway_id" {
  description = "ID de la passerelle Internet"
  value       = aws_internet_gateway.GRP2-internet-gateway.id
}

output "public_route_table_id" {
  description = "ID de la table de routage publique"
  value       = aws_default_route_table.GRP2-public-rt.id
}

output "private_route_table_id" {
  description = "ID de la table de routage privée"
  value       = aws_route_table.GRP2-private-rt.id
}

output "instance_id" {
  description = "ID de l'instance EC2 créée"
  value       = aws_instance.GRP2-EC2.id
}

output "security_group_id" {
  description = "ID du groupe de sécurité"
  value       = aws_default_security_group.GRP2-security-rule.id
}
