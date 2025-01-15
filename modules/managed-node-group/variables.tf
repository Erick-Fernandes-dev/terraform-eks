variable "project_name" {
  type        = string
  description = "Project name to be used to name the resources (Name tag)"

}

variable "tags" {
  type        = map(any)
  description = "Tags to be added to AWS resources"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"

}

variable "subnet_private_1a" {
  type        = string
  description = "Subnet to create EKS Cluster AZ 1a"

}

variable "subnet_private_1b" {
  type        = string
  description = "Subnet to create EKS Cluster AZ 1b"

}


