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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
