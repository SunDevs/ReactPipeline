data "aws_vpc" "vpc" {
  id = var.VPC_ID
}

data "aws_subnet" "subnet" {
  id = var.SUBNET_ID
}

resource "aws_security_group" "ec2" {
  name   = "ec2-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  vpc_id = data.aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["104.192.136.0/21", "185.166.140.0/22", "18.205.93.0/25", "18.234.32.128/25", "13.52.5.0/25"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["104.192.136.0/21", "185.166.140.0/22", "18.205.93.0/25", "18.234.32.128/25", "13.52.5.0/25"]
  }
}

resource "aws_security_group_rule" "httpsIngress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ephimeralIngress" {
  type              = "ingress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "httpsEgress" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

resource "aws_security_group_rule" "ephimeralEgress" {
  type              = "egress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2.id
}

