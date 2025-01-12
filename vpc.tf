resource "aws_vpc" "eks_vpc" {
  # Habilitando DNS Support e DNS Hostnames
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block           = var.cidr_block


  # Implementando tags
  # Vai fazer o merge das tags locais com as tags que estão sendo criadas
  tags = merge(
    local.tags,
    {
      Name = "comunidadedevops-vpc"
    }
  )

}