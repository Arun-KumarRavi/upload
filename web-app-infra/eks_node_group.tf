#eks node group creation

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks_node_group"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids = [
    aws_subnet.private_az_1.id,
    aws_subnet.private_az_2.id
  ]
  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  capacity_type = "ON_DEMAND"

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_role_attachment,
    aws_iam_role_policy_attachment.eks_node_group_cni_policy_attachment,
    aws_iam_role_policy_attachment.eks_node_group_ec2_container_registry_read_only_attachment
  ]

  tags = {
    Name = "DB4-Fresh-Eks-Node-Group"
  }
}

    