
# Garantindo que o Inbound esteja liberado para todos
resource "aws_security_group_rule" "rwa_sg_ingress_tj" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  security_group_id = aws_security_group.rwa_sg_tj.id
}

# Garantindo que o Outbound esteja liberado para todos
resource "aws_security_group_rule" "rwa_sg_egress_tj" {
  type = "egress"
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  security_group_id = aws_security_group.rwa_sg_tj.id
}
