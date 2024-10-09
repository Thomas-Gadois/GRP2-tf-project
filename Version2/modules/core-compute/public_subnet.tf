#public_subnet.tf

# Création de la passerelle Internet pour le VPC
resource "aws_internet_gateway" "GRP2-internet-gateway" {
  vpc_id = aws_vpc.vpc_name.id
  tags = {
    Name = "GRP2-internet-gateway"
  }
}

# Configuration de la table de routage par défaut (publique)
resource "aws_default_route_table" "GRP2-public-rt" {
  default_route_table_id = aws_vpc.vpc_name.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.GRP2-internet-gateway.id
  }

  tags = {
    Name = "GRP2-public-rt"
  }
}

# Création des sous-réseaux publics
resource "aws_subnet" "GRP2-public-subnet" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.vpc_name.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true

  tags = {
    Name = "GRP2-public-subnet-${count.index + 1}"
    # tags rajoutés pour le loadbalancer applicatif
    #"kubernetes.io/cluster/${var.cluster_name}" = "shared"
    #"kubernetes.io/role/elb"                    = "1"
  }
}

# Association des sous-réseaux publics à la table de routage par défaut (publique)
resource "aws_route_table_association" "GRP2_public_assoc" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.GRP2-public-subnet[count.index].id
  route_table_id = aws_default_route_table.GRP2-public-rt.id
}