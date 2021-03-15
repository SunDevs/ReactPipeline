data "aws_ami" "windows" {
  most_recent = true
  filter {
    name = "name"
    values = [
      "Windows_Server-2019-English-Full-Base-*"
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
    "801119661308"
  ]
}

resource "aws_key_pair" "ec2" {
  key_name   = basename(var.PUBLIC_KEY_PATH)
  public_key = file(var.PUBLIC_KEY_PATH)
}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.windows.id
  instance_type               = "t3.small"
  subnet_id                   = data.aws_subnet.subnet.id
  associate_public_ip_address = true
  disable_api_termination     = false
  security_groups             = [aws_security_group.ec2.id]
  key_name                    = aws_key_pair.ec2.key_name
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }
  tags = {
    "Name" = "ec2-${lower(var.PROJECT_NAME)}-${random_pet.value.id}"
  }
}
