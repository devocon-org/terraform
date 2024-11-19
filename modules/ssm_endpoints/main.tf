resource "aws_vpc_endpoint" "ssm" {
  vpc_id          = var.app_zone_vpc
  service_name    = "com.amazonaws.${var.aws_region}.ssm"
  route_table_ids = var.route_table_ids

  tags = {
    Name = "SSM Endpoint - ${var.app_zone_vpc}"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id          = var.app_zone_vpc
  service_name    = "com.amazonaws.${var.region}.ec2messages"
  route_table_ids = var.route_table_ids

  tags = {
    Name = "EC2 Messages Endpoint - ${var.app_zone_vpc}"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id          = var.app_zone_vpc
  service_name    = "com.amazonaws.${var.aws_region}.ssmmessages"
  route_table_ids = var.route_table_ids

  tags = {
    Name = "SSM Messages Endpoint - ${var.app_zone_vpc}"
  }
}
