### Version 3
Comprends le projet de base avec le bonus pour le module et celui pour sécurser le tfstate dans un bucket S3

Un module local nommé "core-compute"

- VPC créé
- 3 subnets publics et privés créés
- Une instance EC2 de type t2.micro créé
- Un security group autorisant la connexion SSH, HTTP et HTTPS (toutes IPs)
 
Le reste du projet, qui exploitera la base de l'infrastructure fournie par le module "core-compute"

- Un cluster EKS en node group (EC2 managées par l'utilisateur et de type t2.micro)
- Les addons VPC-CNI, CoreDNS, et kube-proxy devront être obligatoirement installés sur le cluster
- Le rôle IAM qui devra être associé à EKS sera le rôle EKS_Students, déjà présent sur la plateforme AWS fournie en cours.
- Un load balancer applicatif
