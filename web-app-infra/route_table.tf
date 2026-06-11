# Route table for public subnets → Internet Gateway

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route" "public_rt_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# ── Per-AZ private route tables ───────────────────────────────────────────────
# Each private route table routes through its own AZ-local NAT Gateway.
# This ensures that if one AZ fails the other AZ's private subnets remain
# able to reach the internet without cross-AZ NAT traffic.

# AZ1 private route table → NAT Gateway AZ1
resource "aws_route_table" "private_rt_az1" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "private-rt-az1"
  }
}

resource "aws_route" "private_rt_az1_internet_access" {
  route_table_id         = aws_route_table.private_rt_az1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

# AZ2 private route table → NAT Gateway AZ2
resource "aws_route_table" "private_rt_az2" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "private-rt-az2"
  }
}

resource "aws_route" "private_rt_az2_internet_access" {
  route_table_id         = aws_route_table.private_rt_az2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw_az2.id
}