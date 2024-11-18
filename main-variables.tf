# declare the variables for the resources

variable "aws_region" {
  description = "This is the AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone_a" {
  description = "Availability zone A for subnets"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_b" {
  description = "Availability zone B for subnets"
  type        = string
  default     = "us-east-1b"
}

variable "app_zone_vpc" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.30.0.0/16"
}

variable "app_zone_vpc_public_subnet_a" {
  description = "CIDR block for public subnet A"
  type        = string
  default     = "10.30.1.0/24"
}

variable "app_zone_vpc_public_subnet_b" {
  description = "CIDR block for public subnet B"
  type        = string
  default     = "10.30.2.0/24"
}

variable "app_zone_vpc_private_subnet_a" {
  description = "CIDR block for private subnet A"
  type        = string
  default     = "10.30.3.0/24"
}

variable "app_zone_vpc_private_subnet_b" {
  description = "CIDR block for private subnet B"
  type        = string
  default     = "10.30.4.0/24"
}

variable "key_name" {
  description = "Adding .pem key pair to use for ssh"
  type        = string
  default     = "deployer-key"
}

# variable "key_path" {
#   description = "Path to the private key used for SSH access"
#   type        = string
# }

variable "app_zone_ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  # default     = "ami-005fc0f236362e99f"
}

variable "app_zone_instance_type" {
  description = "Instance type for the EC2"
  type        = string
  # default     = "t2.micro"
}

variable "application_zone_ebs_att_disk_name" {
  type    = string
  default = "/dev/xvdbc"
}

variable "app_zone_ebs_volume_size" {
  description   = "The size of EBS volume"
  type          = number
  # default       = 5   
}

variable "app_zone_ebs_volume_type" {
  description = "The type of EBS volume"
  type        = string
  # default     = "gp3"
}

variable "app_zone_root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  # default     = 30
}

variable "app_zone_root_volume_type" {
  description = "Type of the root EBS volume"
  type        = string
  # default     = "gp3"
}


# identity

# variable "identity_zone_vpc" {
#   description = "CIDR block for the VPC"
#   type        = string
# }

