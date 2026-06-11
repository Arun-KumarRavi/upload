# Elastic IPs and NAT Gateways — one per AZ for high availability

# ── AZ1 (us-east-1a) ──────────────────────────────────────────────────────────

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "eip-nat-gateway-az1"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_az_1.id

  tags = {
    Name = "nat-gateway-az1"
  }

  depends_on = [aws_internet_gateway.igw]
}

# ── AZ2 (us-east-1b) ──────────────────────────────────────────────────────────

resource "aws_eip" "nat_eip_az2" {
  domain = "vpc"

  tags = {
    Name = "eip-nat-gateway-az2"
  }
}

resource "aws_nat_gateway" "nat_gw_az2" {
  allocation_id = aws_eip.nat_eip_az2.id
  subnet_id     = aws_subnet.public_az_2.id

  tags = {
    Name = "nat-gateway-az2"
  }

  depends_on = [aws_internet_gateway.igw]
}
