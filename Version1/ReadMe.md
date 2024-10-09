### Version 1

Comprends le projet de base sans bonus
- VPC créé
- 3 subnets publics et privés créés
- Une instance EC2 de type t2.micro créé
- Un security group autorisant la connexion SSH, HTTP et HTTPS (toutes IPs)
- Un cluster EKS en node group (EC2 managées par l'utilisateur et de type t2.micro)
- Les addons VPC-CNI, CoreDNS, et kube-proxy devront être obligatoirement installés sur le cluster
- Le rôle IAM qui devra être associé à EKS sera le rôle EKS_Students, déjà présent sur la plateforme AWS fournie en cours.
- Un load balancer applicatif
- 
