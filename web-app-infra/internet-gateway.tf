# Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "var.project_name-igw"
  }
}