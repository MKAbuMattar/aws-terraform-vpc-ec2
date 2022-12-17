# resources

# -> resources for the __VPC__ module <-
resource "aws_vpc" "vpc" {
  count = var.vpc_created ? 1 : 0
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support = var.vpc_enable_dns_support

  tags = {
    Name = "${var.environment}-${var.vpc_name}-vpc"
    Environment = var.environment
  }
}

# -> resources for the __PUBLIC_SUBNETS__ module <-
resource "aws_subnet" "public_subnets" {
  count = var.public_subnets_created ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnets_cidr
  availability_zone = var.public_subnets_azs
  map_public_ip_on_launch = var.public_subnets_map_public_ip_on_launch

  tags = {
    Name = "${var.environment}-${var.public_subnets_name}-public-subnet"
    Environment = var.environment
  }
}

# -> resources for the __PRIVATE_SUBNETS__ module <-
resource "aws_subnet" "private_subnets" {
  count = var.private_subnets_created ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_subnets_cidr
  availability_zone = var.private_subnets_azs
  map_public_ip_on_launch = var.private_subnets_map_public_ip_on_launch

  tags = {
    Name = "${var.environment}-${var.private_subnets_name}-private-subnet"
    Environment = var.environment
  }
}

# -> resources for the __INTERNET_GATEWAY__ module <-
resource "aws_internet_gateway" "internet_gateway" {
  count = var.internet_gateway_created ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-${var.internet_gateway_name}-IGW"
    Environment = var.environment
  }
}

# -> resources for the __NAT_EIP__ module <-
resource "aws_eip" "nat_eip" {
  count = var.nat_eip_created ? 1 : 0
  vpc = true
  depends_on = [aws_internet_gateway.internet_gateway]

  tags = {
    Name = "${var.environment}-${var.nat_eip_name}-NAT-EIP"
    Environment = var.environment
  }
}

# -> resources for the __NAT_GATEWAY__ module <-
resource "aws_nat_gateway" "nat_gateway" {
  count = var.nat_gateway_created ? 1 : 0
  allocation_id = aws_eip.nat_eip.id
  subnet_id = element(aws_subnet.public_subnets.*.id, 0)

  tags = {
    Name = "${var.environment}-${var.nat_gateway_name}-NAT-GW"
    Environment = var.environment
  }
}

# -> resources for the __PUBLIC_ROUTE_TABLE__ module <-
resource "aws_route_table" "public_route_table" {
  count = var.public_route_table_created ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.environment}-${var.public_route_table_name}-public-route-table"
    Environment = var.environment
  }
}

# -> resources for the __PUBLIC_ROUTE_TABLE_ASSOCIATION__ module <-
resource "aws_route_table_association" "public_route_table_association" {
  count = var.public_route_table_association_created ? 1 : 0
  subnet_id = element(aws_subnet.public_subnets.*.id, 0)
  route_table_id = aws_route_table.public_route_table.id
}

# -> resources for the __PRIVATE_ROUTE_TABLE__ module <-
resource "aws_route_table" "private_route_table" {
  count = var.private_route_table_created ? 1 : 0
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "${var.environment}-${var.private_route_table_name}-private-route-table"
    Environment = var.environment
  }
}

# -> resources for the __PRIVATE_ROUTE_TABLE_ASSOCIATION__ module <-
resource "aws_route_table_association" "private_route_table_association" {
  count = var.private_route_table_association_created ? 1 : 0
  subnet_id = element(aws_subnet.private_subnets.*.id, 0)
  route_table_id = aws_route_table.private_route_table.id
}

# -> resources for the __SECURITY_GROUP__ module <-
resource "aws_security_group" "security_group" {
  count = var.security_group_created ? 1 : 0
  name = "${var.environment}-${var.security_group_name}-SG"
  description = var.security_group_description
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-${var.security_group_name}-SG"
    Environment = var.environment
  }
}

# -> resources for the __SECURITY_GROUP_INGRESS_RULES__ module <-
variable "security_group_ingress_rules" {
  description = "Ingress rules for the security group"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
resource "aws_security_group_rule" "security_group_rules" {
  count = var.security_group_ingress_rules_created ? 1 : 0
  description = var.security_group_ingress_rules[count.index].description
  from_port = var.security_group_ingress_rules[count.index].from_port
  to_port = var.security_group_ingress_rules[count.index].to_port
  protocol = var.security_group_ingress_rules[count.index].protocol
  cidr_blocks = var.security_group_ingress_rules[count.index].cidr_blocks
  type = "ingress"
  security_group_id = aws_security_group.security_group.id
}

# -> resources for the __EC2_INSTANCE__ module <-
resource "aws_instance" "ec2_instance" {
  count = var.ec2_instance_created ? 1 : 0
  ami = var.ec2_instance_ami
  instance_type = var.ec2_instance_type
  key_name = var.ec2_instance_key_name
  subnet_id = element(aws_subnet.private_subnets.*.id, 0)
  vpc_security_group_ids = [aws_security_group.security_group.id]
  associate_public_ip_address = var.ec2_instance_associate_public_ip_address

  tags = {
    Name = "${var.environment}-${var.ec2_instance_name}-EC2"
    Environment = var.environment
  }
}

# -> resources for the __EC2_INSTANCE_EIP__ module <-
resource "aws_eip" "ec2_instance_eip" {
  count = var.ec2_instance_eip_created ? 1 : 0
  vpc = true

  tags = {
    Name = "${var.environment}-${var.ec2_instance_eip_name}-EIP"
    Environment = var.environment
  }
}

# -> resources for the __EC2_INSTANCE_EIP_ASSOCIATION__ module <-
resource "aws_eip_association" "ec2_instance_eip_association" {
  count = var.ec2_instance_eip_association_created ? 1 : 0
  allocation_id = aws_eip.ec2_instance_eip.id
  instance_id = aws_instance.ec2_instance.id
}