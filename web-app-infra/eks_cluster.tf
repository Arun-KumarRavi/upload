#creation of  eks cluster 

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks_cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids = [
      aws_subnet.public_az_1.id,
      aws_subnet.public_az_2.id,
      aws_subnet.private_az_1.id,
      aws_subnet.private_az_2.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_attachment,
    aws_cloudwatch_log_group.eks_log_group
  ]

  tags = {
    Name = "DB4-Fresh-Eks-Cluster"
  }
}





