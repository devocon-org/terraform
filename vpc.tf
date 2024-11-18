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