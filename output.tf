# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.
output "subnet_pub_1a" {
  value = module.eks_network.subnet_pub_1a

}

# Fazendo a chama do output do módulo cluster imprimir a configuração da VPC
output "eks_vpc_config" {
  value = module.eks_cluster.eks_vpc_config

}

# output "oidc" {
#   value = module.eks_cluster.oidc

# }

output "oidc" {
  value = module.eks_cluster.oidc

}

output "ca" {
  value = module.eks_cluster.certificate_authority

}

output "endpoint" {
  value = module.eks_cluster.endpoint

}