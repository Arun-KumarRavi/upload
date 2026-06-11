# IAM Roles for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}


# Attach the AmazonEKSClusterPolicy to the EKS cluster role
resource "aws_iam_role_policy_attachment" "eks_cluster_role_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}



# IAM Role for EKS node group 
resource "aws_iam_role" "eks_node_group_role" {
  name = "eks_node_group_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the AmazonEKSWorkerNodePolicy, AmazonEC2ContainerRegistryReadOnly, and AmazonEKS_CNI_Policy to the EKS node group role
resource "aws_iam_role_policy_attachment" "eks_node_group_role_attachment" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_node_group_ec2_container_registry_read_only_attachment" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eks_node_group_cni_policy_attachment" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}





# IAM Role for Jenkins EC2 instance
resource "aws_iam_role" "jenkins_ec2_role" {
  name = "jenkins_ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ECR permissions for Jenkins EC2 instance
resource "aws_iam_policy" "jenkins_ecr_policy" {
  name = "jenkins_ecr_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{

      Effect = "Allow"
      Action = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:UploadsLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:BatchGetImage"
      ]
      Resource = "*"
    }]
  })
}

# Attach the ECR policy to the Jenkins EC2 role
resource "aws_iam_role_policy_attachment" "jenkins_ec2_ecr_policy_attachment" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = aws_iam_policy.jenkins_ecr_policy.arn
}



#create cloudwatch policy for Jenkins EC2 instance
resource "aws_iam_policy" "jenkins_cloudwatch_policy" {
  name = "jenkins_cloudwatch_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{

      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ]
      Resource = "*"
    }]
  })
}

# Attach the CloudWatch policy to the Jenkins EC2 role
resource "aws_iam_role_policy_attachment" "jenkins_ec2_cloudwatch_policy_attachment" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = aws_iam_policy.jenkins_cloudwatch_policy.arn
}