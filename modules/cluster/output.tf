# Output do cluster

# Output é utilizado para exportar valores de um módulo para outros módulos ou para o módulo raiz.

# Imprimir a configuração da VPC
output "eks_vpc_config" {
  value = aws_eks_cluster.eks_cluster.vpc_config

}

# output "oidc" {
#   value = data.tls_certificate.eks_oidc_tls_certificate.certificates[*].sha1_fingerprint
# }

# Imprimir o nome do cluster
output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.id
}

# Impressão do OIDC
output "oidc" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

# Imprimir o certificado da autoridade
output "certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data

}

output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint

}