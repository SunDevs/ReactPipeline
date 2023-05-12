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


resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.ec2.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.ec2.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 1024
  ip_protocol = "tcp"
  to_port     = 65535
}

resource "aws_vpc_security_group_egress_rule" "https" {
  security_group_id = aws_security_group.ec2.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "ephimeral" {
  security_group_id = aws_security_group.ec2.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 1024
  ip_protocol = "tcp"
  to_port     = 65535
}
