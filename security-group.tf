resource "aws_security_group" "sg-MW" {
  description = "Security group for MediWiki"
  name        = "ssh-allow"
  vpc_id      = aws_vpc.vpc-MW.id
}
resource "aws_security_group_rule" "sg-ssh-MW" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-MW.id
}

resource "aws_security_group_rule" "sg-http-MW" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-MW.id
}

resource "aws_security_group_rule" "sg-egress-MW" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-MW.id
}