module "eks_network" {
  source = "./modules/network"
  # Passando as variáveis para o módulo
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = local.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  tags             = local.tags
  public_subnet_1a = module.eks_network.subnet_pub_1a
  public_subnet_1b = module.eks_network.subnet_pub_1b
}