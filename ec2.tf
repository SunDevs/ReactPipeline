data "aws_ami" "windows" {
  most_recent = true
  filter {
    name = "name"
    values = [
      "WindowsServer2019-NodeJS14-*"
    ]
  }
  filter {
    name = "root-device-type"
    values = [
      "ebs"
    ]
  }
  filter {
    name = "virtualization-type"
    values = [
      "hvm"
    ]
  }
  owners = [
    "766242209032"
  ]
}

resource "aws_key_pair" "ec2" {
  key_name   = "key-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  public_key = var.EC2_PUBLIC_KEY
}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.windows.id
  instance_type               = "t3.small"
  subnet_id                   = data.aws_subnet.subnet.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2.id
  disable_api_termination     = false
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = aws_key_pair.ec2.key_name
  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }
  tags = {
    "Name" = "ec2-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  }
}
