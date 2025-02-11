# create security group for the application load balancer
# terraform aws create security group

# app_zone_test
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


# #application_zone_prd
# resource "aws_security_group" "alb_security_group" {
#   name        = "alb security group"
#   description = "enable http/https access on port 80/443"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     description      = "http access"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     description      = "https access"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = -1
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags   = {
#     Name = "alb security group"
#   }
# }

# # create security group for the asg
# resource "aws_security_group" "asg_security_group" {
#   name        = "asg security group"
#   description = "enable http/https access on port 80/443 via alb sg"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     description      = "http access"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     security_groups  = [aws_security_group.alb_security_group.id]
#   }

#   ingress {
#     description      = "https access"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     security_groups  = [aws_security_group.alb_security_group.id]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = -1
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags   = {
#     Name = "asg security group"
#   }
# }