#frontend ecr repository
resource "aws_ecr_repository" "frontend_ecr_repo" {
  name = "frontend-ecr-repo"

  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "frontend-ecr-repo"
    Environment = "deployment"
    terraform   = "true"
  }
}

#backend ecr repository

resource "aws_ecr_repository" "backend_ecr_repo" {
  name = "backend-ecr-repo"

  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "backend-ecr-repo"
    Environment = "deployment"
    terraform   = "true"
  }
}  