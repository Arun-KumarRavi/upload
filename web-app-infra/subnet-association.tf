# ── Public subnets → Public route table ───────────────────────────────────────

resource "aws_route_table_association" "public_az_1_association" {
  subnet_id      = aws_subnet.public_az_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_az_2_association" {
  subnet_id      = aws_subnet.public_az_2.id
  route_table_id = aws_route_table.public_rt.id
}

# ── Private App subnets → per-AZ private route tables ─────────────────────────
# AZ1 private subnet routes through NAT Gateway in AZ1
# AZ2 private subnet routes through NAT Gateway in AZ2

resource "aws_route_table_association" "private_az_1_association" {
  subnet_id      = aws_subnet.private_az_1.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "private_az_2_association" {
  subnet_id      = aws_subnet.private_az_2.id
  route_table_id = aws_route_table.private_rt_az2.id
}

# ── Private DB subnets → per-AZ private route tables ──────────────────────────
# DB subnets follow the same AZ-local NAT pattern for consistent HA behaviour

resource "aws_route_table_association" "private_db_az_1_association" {
  subnet_id      = aws_subnet.private_db_az_1.id
  route_table_id = aws_route_table.private_rt_az1.id
}

resource "aws_route_table_association" "private_db_az_2_association" {
  subnet_id      = aws_subnet.private_db_az_2.id
  route_table_id = aws_route_table.private_rt_az2.id
}
