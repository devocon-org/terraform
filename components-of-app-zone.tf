# create the internet components


# VPC
resource "aws_vpc" "app_zone_vpc" {
  cidr_block = var.app_zone_vpc

  tags = {
    Name = "application-zone-vpc"
  }
}

# Subnets
resource "aws_subnet" "app_zone_vpc_public_subnet_a" {
  vpc_id                  = aws_vpc.app_zone_vpc.id
  cidr_block              = var.app_zone_vpc_public_subnet_a
  availability_zone       = var.availability_zone_a
  map_public_ip_on_launch = false

  tags = {
    Name = "application-zone-public-subnet-a"
  }
}

resource "aws_subnet" "app_zone_vpc_public_subnet_b" {
  vpc_id                  = aws_vpc.app_zone_vpc.id
  cidr_block              = var.app_zone_vpc_public_subnet_b
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "application-zone-public-subnet-b"
  }
}

resource "aws_subnet" "app_zone_vpc_private_subnet_a" {
  vpc_id                  = aws_vpc.app_zone_vpc.id
  cidr_block              = var.app_zone_vpc_private_subnet_a
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "application-zone-private-subnet-a"
  }
}

resource "aws_subnet" "app_zone_vpc_private_subnet_b" {
  vpc_id                  = aws_vpc.app_zone_vpc.id
  cidr_block              = var.app_zone_vpc_private_subnet_b
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "application-zone-private-subnet-b"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "app_zone_vpc_igw" {
  vpc_id = aws_vpc.app_zone_vpc.id

  tags = {
    Name = "application-zone-vpc-igw"
  }
}

# Route Tables
resource "aws_route_table" "app_zone_vpc_public_rt" {
  vpc_id = aws_vpc.app_zone_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app_zone_vpc_igw.id
  }

  tags = {
    Name = "application-zone-public-rt"
  }
}

resource "aws_route_table_association" "app_public_subnet_a_association" {
  subnet_id      = aws_subnet.app_zone_vpc_public_subnet_a.id
  route_table_id = aws_route_table.app_zone_vpc_public_rt.id
}

resource "aws_route_table_association" "app_public_subnet_b_association" {
  subnet_id      = aws_subnet.app_zone_vpc_public_subnet_b.id
  route_table_id = aws_route_table.app_zone_vpc_public_rt.id
}

resource "aws_route_table" "app_zone_vpc_private_rt" {
  vpc_id = aws_vpc.app_zone_vpc.id

  tags = {
    Name = "application-zone-private-rt"
  }
}

resource "aws_route_table_association" "app_private_subnet_a_association" {
  subnet_id      = aws_subnet.app_zone_vpc_private_subnet_a.id
  route_table_id = aws_route_table.app_zone_vpc_private_rt.id
}

resource "aws_route_table_association" "app_private_subnet_b_association" {
  subnet_id      = aws_subnet.app_zone_vpc_private_subnet_b.id
  route_table_id = aws_route_table.app_zone_vpc_private_rt.id
}

# Security Group
resource "aws_security_group" "app_zone_vpc_sg" {
  name        = "app_zone_vpc_sg"
  description = "Allow all inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.app_zone_vpc.id

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

  tags = {
    Name = "application-zone-vpc-sg-allow_all"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQAREXTV1as4qvLXZZ/JwNJAZjEceqLiSrFeMOhLvPkcjF4eZhS9cQUwcthupAvbElrXRZZg5OIMeuTbtEUdHhwA8POIgUIiftmF3K7RHU7P90rFGYzb9RNEcc0wSfI044EhJhA/aclX3IQixHMyeTCec27Va0+NFZW0Q/gCKY23OdRD1QJjpzgAclIaOac+S2HSLhKIwY0ISEIs60DFMBTzjFo6iWmrvvAw4CTxK+ZZZ+p4Ct8htaawPNXggqySgg7LUHKstkZnnPoRGXgYsj5APunXLqdRv7xUt9XTRH70CPocxJ4yhrU4uBL3byhY5l+a+ST+sLap4tjSG9H1AiPWGlaiygSoHoKCLHlGcBzXglJiryrr1Om4p+a9oSrI37jnc+fJd3RF0lAbIaQP1hnzo+x0owbMH9MK0GrhSiCVl8TQnr0FSsQIbTc3kiVb8mzpVICgcJo7l+sr5etrzmcJkCyJWFGHsV6sLce9TKPMSa3HeyJSVdxlgvg4X3jRP1NZguqqAZ4h5ppdeCaOa1NeG0qu0j/CxxqBw5JLlWYK4saghoQpPKIVmEz4YS/VAVE0q04Iq36Jrz1d3eUJxNush1I3eJZ3RqmpL9N0F7g2n1Z/9g/YQG5+7o9Z+8aBYYsHQvGEJtkSybGvUxHjgxpf4jcPfxK+9qGPWQoI1kGQ== kendanicrio@gmail.com"
}

#eip
resource "aws_eip" "app_zone_public_eip" {
  instance = aws_instance.web.id
  domain   = "vpc"
}

# EC2 Instances
resource "aws_instance" "app_zone_ec2_public_a" {
  ami                         = var.app_zone_ami_id
  instance_type               = var.app_zone_instance_type
  subnet_id                   = aws_subnet.app_zone_vpc_public_subnet_a.id
  associate_public_ip_address = false
  disable_api_termination     = true
  vpc_security_group_ids      = [aws_security_group.app_zone_vpc_sg.id]
  key_name                    = var.key_name

  root_block_device {
    volume_size    = var.app_zone_root_volume_size
    volume_type    = var.app_zone_root_volume_type
    tags = {
      Name = "application-zone-ec2-ebs-os_root-public-a"
    }
  }

  tags = {
    Name = "application-zone-ec2-public-a"
  }
}

resource "aws_ebs_volume" "app_zone_ec2_public_a_ebs_vol" {
  availability_zone = var.availability_zone_a
  size              = var.app_zone_ebs_volume_size
  type              = var.app_zone_ebs_volume_type
  encrypted         = true
  tags = {
    Name = "application-zone-ec2-ebs-att-public-a"
  }
}

resource "aws_volume_attachment" "app_zone_ec2_public_a_ebs_vol_att" {
  device_name  = var.application_zone_ebs_att_disk_name
  volume_id    = aws_ebs_volume.app_zone_ec2_public_a_ebs_vol.id
  instance_id  = aws_instance.app_zone_ec2_public_a.id
  force_detach = true
  
}

resource "aws_instance" "app_zone_ec2_public_b" {
  ami                         = var.app_zone_ami_id
  instance_type               = var.app_zone_instance_type
  subnet_id                   = aws_subnet.app_zone_vpc_public_subnet_b.id
  # associate_public_ip_address = false
  disable_api_termination     = true
  vpc_security_group_ids      = [aws_security_group.app_zone_vpc_sg.id]
  key_name                    = var.key_name

  root_block_device {
    volume_size    = var.app_zone_root_volume_size
    volume_type    = var.app_zone_root_volume_type
    tags = {
      Name = "application-zone-ec2-ebs-os_root-public-b"
    }
  }

  tags = {
    Name = "application-zone-ec2-public-b"
  }
}

resource "aws_ebs_volume" "app_zone_ec2_public_b_ebs_vol" {
  availability_zone = var.availability_zone_b
  size              = var.app_zone_ebs_volume_size
  type              = var.app_zone_ebs_volume_type
  encrypted         = true
  tags = {
    Name = "application-zone-ec2-ebs-att-public-b"
  }
}

resource "aws_volume_attachment" "app_zone_ec2_public_b_ebs_vol_att" {
  device_name  = var.application_zone_ebs_att_disk_name
  volume_id    = aws_ebs_volume.app_zone_ec2_public_b_ebs_vol.id
  instance_id  = aws_instance.app_zone_ec2_public_b.id
  force_detach = true
}

resource "aws_instance" "app_zone_ec2_private_a" {
  ami                         = var.app_zone_ami_id
  instance_type               = var.app_zone_instance_type
  subnet_id                   = aws_subnet.app_zone_vpc_private_subnet_a.id
  associate_public_ip_address = false
  disable_api_termination     = true
  vpc_security_group_ids      = [aws_security_group.app_zone_vpc_sg.id]
  key_name                    = var.key_name

  root_block_device {
    volume_size    = var.app_zone_root_volume_size
    volume_type    = var.app_zone_root_volume_type
    tags = {
      Name = "application-zone-ec2-ebs-os_root-private-a"
    }
  }

  tags = {
    Name = "application-zone-ec2-private-a"
  }
}

resource "aws_ebs_volume" "app_zone_ec2_private_a_ebs_vol" {
  availability_zone = var.availability_zone_a
  size              = var.app_zone_ebs_volume_size
  type              = var.app_zone_ebs_volume_type
  encrypted         = true
  tags = {
    Name = "application-zone-ec2-ebs-att-private-a"
  }
}

resource "aws_volume_attachment" "app_zone_ec2_private_a_ebs_vol_att" {
  device_name  = var.application_zone_ebs_att_disk_name
  volume_id    = aws_ebs_volume.app_zone_ec2_private_a_ebs_vol.id
  instance_id  = aws_instance.app_zone_ec2_private_a.id
  force_detach = true
}

resource "aws_instance" "app_zone_ec2_private_b" {
  ami                         = var.app_zone_ami_id
  instance_type               = var.app_zone_instance_type
  subnet_id                   = aws_subnet.app_zone_vpc_private_subnet_b.id
  associate_public_ip_address = false
  disable_api_termination     = true
  vpc_security_group_ids      = [aws_security_group.app_zone_vpc_sg.id]
  key_name                    = var.key_name

  root_block_device {
    volume_size    = var.app_zone_root_volume_size
    volume_type    = var.app_zone_root_volume_type
    tags = {
      Name = "application-zone-ec2-ebs-os_root-private-b"
    }
  }

  tags = {
    Name = "application-zone-ec2-private-b"
  }
}

resource "aws_ebs_volume" "app_zone_ec2_private_b_ebs_vol" {
  availability_zone = var.availability_zone_b
  size              = var.app_zone_ebs_volume_size
  type              = var.app_zone_ebs_volume_type
  encrypted         = true
  tags = {
    Name = "application-zone-ec2-ebs-att-private-b"
  }
}

resource "aws_volume_attachment" "app_zone_ec2_private_b_ebs_vol_att" {
  device_name  = var.application_zone_ebs_att_disk_name
  volume_id    = aws_ebs_volume.app_zone_ec2_private_b_ebs_vol.id
  instance_id  = aws_instance.app_zone_ec2_private_b.id
  force_detach = true
}
