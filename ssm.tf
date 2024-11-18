# Define IAM Role for EC2 with SSM permissions
resource "aws_iam_role" "ec2_ssm_role" {
  name               = "EC2-SSM-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      },
    ]
  })
}

# Attach the AmazonSSMManagedInstanceCore policy to the role
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Define VPC endpoints for SSM services (optional, only for private subnets)
resource "aws_vpc_endpoint" "ssm" {
  vpc_id = var.vpc_id  # Pass VPC ID as a variable or hardcode it

  service_name = "com.amazonaws.${var.region}.ssm"
  route_table_ids = var.route_table_ids  # Pass route table IDs
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.region}.ec2messages"
  route_table_ids = var.route_table_ids
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id = var.vpc_id

  service_name = "com.amazonaws.${var.region}.ssmmessages"
  route_table_ids = var.route_table_ids
}


