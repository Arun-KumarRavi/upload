# Security Groups for Application load balancer 

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Security Group for Application Load Balancer"
  vpc_id      = aws_vpc.project-vpc.id

  ingress {
    description = "Allow HTTP traffic from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS traffic from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
  }
}




#Eks nodes security group

resource "aws_security_group" "eks_nodes_sg" {
  name        = "eks_nodes_sg"
  description = "Security Group for EKS Nodes"
  vpc_id      = aws_vpc.project-vpc.id

  ingress {
    description     = "Allow inbound traffic from EKS worker nodes"
    from_port       = 30000
    to_port         = 32767
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks_nodes_sg"
  }
}

# RDS security group

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Security Group for RDS"
  vpc_id      = aws_vpc.project-vpc.id

  ingress {
    description     = "Allow inbound traffic from EKS worker nodes"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_nodes_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds_sg"
  }
}




#Jenkins security group


resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Security Group for Jenkins"
  vpc_id      = aws_vpc.project-vpc.id


  ingress {
    description     = "Allow inbound traffic to Jenkins UI from within VPC only"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_nodes_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_sg"
  }
}
