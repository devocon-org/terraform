# Adding all the vpc var

resource "aws_vpc" "app_zone_vpc" {
  cidr_block = var.app_zone_vpc

  tags = {
    Name = "application-zone-vpc"
  }
}

# resource "aws_vpc" "identity_zone_vpc" {
#   cidr_block = var.identity_zone_vpc

#   tags  = {
#     Name = "identity_zone_vpc"
#   }
# }

module "ssm_endpoints_vpc_1" {
  source          = "./modules/ssm_endpoints"
  vpc_id          = aws_vpc.app_zone_vpc.id
  route_table_ids = ["rtb-xxxxxxxx"]  # Pass appropriate route table IDs
}

module "ssm_endpoints_vpc_2" {
  source          = "./modules/ssm_endpoints"
  vpc_id          = "vpc-yyyyyyyy"
  route_table_ids = ["rtb-yyyyyyyy"]
}
