#EKS.tf

# Création du cluster EKS
resource "aws_eks_cluster" "GRP2-eks-cluster" {
  name     = var.cluster_name
  role_arn = "arn:aws:iam::268849317545:role/EKS_Students" 

  vpc_config {
    subnet_ids              = concat(aws_subnet.GRP2-public-subnet[*].id, aws_subnet.GRP2-private-subnet[*].id)
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  # tags rajoutés pour le loadbalancer applicatif
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  # Attacher les politiques IAM au cluster
  depends_on = [aws_iam_role_policy_attachment.AmazonEKSClusterPolicy]
}

# Création du node group EKS
resource "aws_eks_node_group" "GRP2-node-group" {
  cluster_name    = aws_eks_cluster.GRP2-eks-cluster.name
  node_group_name = "GRP2-node-group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = aws_subnet.GRP2-private-subnet[*].id

  # Config de l'autoscaling des nœuds du cluster
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t2.micro"]

  # Attache les politiques IAM groupe de noeuds
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

# Installation des add-ons EKS
resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.GRP2-eks-cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.GRP2-eks-cluster.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.GRP2-eks-cluster.name
  addon_name   = "kube-proxy"
}

# Rôle IAM pour le node group EKS
resource "aws_iam_role" "eks_node_group_role" {
  name = "GRP2-eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attachement des politiques nécessaires au rôle du groupe de nœuds
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role.name
}

# Attachement de la politique EKS Cluster au rôle EKS_Students
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "EKS_Students"
}