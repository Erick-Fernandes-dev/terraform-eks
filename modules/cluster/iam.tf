# Arquivo responsável por criar as permissões necessárias para o EKS gerenciar clusters

# Vamos criar uma role para o EKS gerenciar clusters
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-cluster-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-cluster-role"
    }
  )
}

# Vamos anexar a policy AmazonEKSClusterPolicy ao role criado que permite o EKS gerenciar clusters
resource "aws_iam_role_policy_attachment" "eks_cluster_role_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}