# ── Subnet outputs ────────────────────────────────────────────────────────────

output "public_subnet" {
  value = [
    aws_subnet.public_az_1.id,
    aws_subnet.public_az_2.id
  ]
}

output "private_subnet" {
  value = [
    aws_subnet.private_az_1.id,
    aws_subnet.private_az_2.id
  ]
}

output "db_subnet" {
  value = [
    aws_subnet.private_db_az_1.id,
    aws_subnet.private_db_az_2.id
  ]
}

# ── Internet Gateway ──────────────────────────────────────────────────────────

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

# ── NAT Gateways (one per AZ for high availability) ───────────────────────────

output "nat_eip_az1_id" {
  description = "Elastic IP for NAT Gateway in AZ1 (us-east-1a)"
  value       = aws_eip.nat_eip.id
}

output "nat_eip_az2_id" {
  description = "Elastic IP for NAT Gateway in AZ2 (us-east-1b)"
  value       = aws_eip.nat_eip_az2.id
}

output "nat_gateway_az1_id" {
  description = "NAT Gateway ID in AZ1 (us-east-1a)"
  value       = aws_nat_gateway.nat_gw.id
}

output "nat_gateway_az2_id" {
  description = "NAT Gateway ID in AZ2 (us-east-1b)"
  value       = aws_nat_gateway.nat_gw_az2.id
}

# ── EKS Cluster ───────────────────────────────────────────────────────────────

output "eks_cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_node_group_id" {
  value = aws_eks_node_group.eks_node_group.id
}

# ── ECR Repositories ──────────────────────────────────────────────────────────

output "frontend_ecr_repository_url" {
  value = aws_ecr_repository.frontend_ecr_repo.repository_url
}

output "backend_ecr_repository_url" {
  value = aws_ecr_repository.backend_ecr_repo.repository_url
}

# ── Jenkins Server ────────────────────────────────────────────────────────────

output "jenkins_server_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "jenkins_server_private_ip" {
  value = aws_instance.jenkins_server.private_ip
}

# ── RDS ───────────────────────────────────────────────────────────────────────

output "rds_instance_endpoint" {
  value = aws_db_instance.mysql_instance.endpoint
}

output "secretsmanager_db_credentials_arn" {
  description = "The ARN of the DB credentials secret in AWS Secrets Manager"
  value       = aws_secretsmanager_secret.db_credentials.arn
}


# ── Application Load Balancer ─────────────────────────────────────────────────

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

# ── Backup & Disaster Recovery ────────────────────────────────────────────────

output "backup_vault_arn" {
  description = "The ARN of the AWS Backup Vault"
  value       = aws_backup_vault.main.arn
}

output "backup_plan_arn" {
  description = "The ARN of the AWS Backup Plan"
  value       = aws_backup_plan.main.arn
}

