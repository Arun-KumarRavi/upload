# public subnet availability zones- 1

resource "aws_subnet" "public_az_1" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = var.public_subnet_az_1_cidr
  availability_zone = var.public_subnet_az_1_az


  tags = {
    Name        = var.public_subnet_az_1_name
    Environment = "deployment"
    terraform   = "true"
  }
}
# public subnet availability zones- 2

resource "aws_subnet" "public_az_2" {
  vpc_id                  = aws_vpc.project-vpc.id
  cidr_block              = var.public_subnet_az_2_cidr
  availability_zone       = var.public_subnet_az_2_az
  map_public_ip_on_launch = true

  tags = {
    Name        = var.public_subnet_az_2_name
    Environment = "deployment"
    terraform   = "true"
  }
}





# private subnet availability zones- 1
resource "aws_subnet" "private_az_1" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = var.private_subnet_az_1_cidr
  availability_zone = var.private_subnet_az_1_az

  tags = {
    Name        = var.private_subnet_az_1_name
    Environment = "deployment"
    terraform   = "true"
  }
}
# private subnet availability zones- 2

resource "aws_subnet" "private_az_2" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = var.private_subnet_az_2_cidr
  availability_zone = var.private_subnet_az_2_az

  tags = {
    Name        = var.private_subnet_az_2_name
    Environment = "deployment"
    terraform   = "true"
  }
}


# private DB subnet availability zones- 1

resource "aws_subnet" "private_db_az_1" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = var.private_db_subnet_az_1_cidr
  availability_zone = var.private_db_subnet_az_1_az


  tags = {
    Name        = var.private_db_subnet_az_1_name
    Environment = "deployment"
    terraform   = "true"
  }
}

# private DB subnet availability zones- 2

resource "aws_subnet" "private_db_az_2" {
  vpc_id            = aws_vpc.project-vpc.id
  cidr_block        = var.private_db_subnet_az_2_cidr
  availability_zone = var.private_db_subnet_az_2_az

  tags = {
    Name        = var.private_db_subnet_az_2_name
    Environment = "deployment"
    terraform   = "true"
  }
}