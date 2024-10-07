# Création de l'instance EC2
resource "aws_instance" "GRP2-EC2" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.GRP2-public-subnet[0].id # Placer l'instance dans le premier sous-réseau public
  vpc_security_group_ids = [aws_default_security_group.GRP2-security-rule.id]
  key_name               = "GRP2-Key"

  tags = {
    Name = "GRP2-EC2"
  }
}
