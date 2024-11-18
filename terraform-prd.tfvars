# production environment run-time terraform variables

#comman_env
environment_name        = "prd"
key_name                = "deployer-key" 
aws_region              = "us-east-1"
availability_zone_a     = "us-east-1a"
availability_zone_b     = "us-east-1b"
# key_path                = "/home/ken/.ssh/id_rsa"


#app_zone
app_zone_vpc                     = "10.30.0.0/16"
app_zone_vpc_public_subnet_a     = "10.30.1.0/24"
app_zone_vpc_public_subnet_b     = "10.30.2.0/24"
app_zone_vpc_private_subnet_a    = "10.30.3.0/24"
app_zone_vpc_private_subnet_b    = "10.30.4.0/24"
app_zone_ami_id                  = "ami-005fc0f236362e99f"
app_zone_instance_type           = "t2.micro"
app_zone_root_volume_type        = "gp3"
app_zone_root_volume_size        = 8
app_zone_ebs_volume_type         = "gp3"
app_zone_ebs_volume_size         = 5

# #identity_zone
# identity_zone_vpc                      = "10.40.0.0/16"
# identity_zone_vpc_private_subnet_a     = "10.40.1.0/24"
# identity_zone_vpc_private_subnet_b     = "10.40.2.0/24"
# identity_zone_vpc_private_subnet_c     = "10.40.3.0/24"
# identity_zone_vpc_private_subnet_d     = "10.40.4.0/24"
# identity_zone_ami_id                  = "ami-005fc0f236362e99f"
# identity_zone_instance_type           = "t2.micro"
# identity_zone_root_volume_type        = "gp3"
# identity_zone_root_volume_size        = 8
# identity_zone_ebs_volume_type         = "gp3"
# identity_zone_ebs_volume_size         = 5



