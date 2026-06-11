# CloudWatch Log Group for EKS Control Plane
# Note: EKS log group name MUST follow the format `/aws/eks/<cluster_name>/cluster`
resource "aws_cloudwatch_log_group" "eks_log_group" {
  name              = "/aws/eks/eks_cluster/cluster"
  retention_in_days = 7

  tags = {
    Environment = "deployment"
    terraform   = "true"
  }
}

# CloudWatch Log Group for VPC Flow Logs
resource "aws_cloudwatch_log_group" "vpc_flow_log_group" {
  name              = "/aws/vpc/project-vpc-flow-logs"
  retention_in_days = 7

  tags = {
    Environment = "deployment"
    terraform   = "true"
  }
}

# IAM Role for VPC Flow Logs to publish to CloudWatch
resource "aws_iam_role" "vpc_flow_log_role" {
  name = "vpc_flow_log_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for VPC Flow Logs
resource "aws_iam_role_policy" "vpc_flow_log_policy" {
  name = "vpc_flow_log_policy"
  role = aws_iam_role.vpc_flow_log_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# VPC Flow Logs Configuration
resource "aws_flow_log" "vpc_flow_log" {
  iam_role_arn    = aws_iam_role.vpc_flow_log_role.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_log_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.project-vpc.id

  tags = {
    Name        = "project-vpc-flow-logs"
    Environment = "deployment"
    terraform   = "true"
  }
}
