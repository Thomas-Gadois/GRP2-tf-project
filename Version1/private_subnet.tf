#private_subnet.tf

# Création de la NAT Gateway
resource "aws_nat_gateway" "GRP2-NAT-gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.GRP2-public-subnet[0].id # Placer la NAT Gateway dans le premier sous-réseau public

  tags = {
    Name = "GRP2-NAT-gateway"
  }

  depends_on = [aws_internet_gateway.GRP2-internet-gateway]
}

# Création d'une adresse IP Elastic pour la NAT Gateway
resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.GRP2-internet-gateway]
}

# Création de la table de routage pour les sous-réseaux privés
resource "aws_route_table" "GRP2-private-rt" {
  vpc_id = aws_vpc.vpc_name.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.GRP2-NAT-gateway.id
  }

  tags = {
    Name = "GRP2-private-rt"
  }
}

# Création des sous-réseaux privés
resource "aws_subnet" "GRP2-private-subnet" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.vpc_name.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + var.subnet_count)
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name = "GRP2-private-subnet-${count.index + 1}"
  }
}

# Association des sous-réseaux privés à la table de routage privée
resource "aws_route_table_association" "GRP2_private_assoc" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.GRP2-private-subnet[count.index].id
  route_table_id = aws_route_table.GRP2-private-rt.id
}
