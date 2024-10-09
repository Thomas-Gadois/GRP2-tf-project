#data.tf
# Data source pour obtenir les zones de disponibilité (AZs) pour générer les subnets
data "aws_availability_zones" "available" {
  state = "available"
}

# Data source pour récupérer le rôle IAM EKS_Students
data "aws_iam_role" "eks_students_role" {
  name = "EKS_Students"
}

# Data source pour obtenir l'AMI Amazon Linux 2023 la plus récente
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
