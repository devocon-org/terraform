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

module "ssm_endpoints" {
  source = "./modules/ssm_endpoints"

  app_zone_vpc   = var.app_zone_vpc # Replace with your VPC resource
  aws_region     = var.aws_region           # Ensure aws_region is defined somewhere
  route_table_ids = [
    aws_route_table.app_zone_vpc_public_rt.id,   # Public route table
    aws_route_table.app_zone_vpc_private_rt.id    # Private route table
  ]
}
