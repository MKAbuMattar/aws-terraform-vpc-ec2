# outputs

# -> output for the __VPC__ ID (for use in other modules) <-
output "vpc" {
  description = "VPC ID"
  value= concat(aws_vpc.vpc.*.id, [""])[0]
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value= concat(aws_vpc.vpc.*.cidr_block, [""])[0]
}

# -> output for the __PUBLIC_SUBNETS__ IDs <-

output "public_subnets" {
  description = "Public Subnets IDs"
  value= aws_subnet.public.*.id
}

output "public_subnets_cidr" {
  description = "Public Subnets CIDR"
  value= aws_subnet.public.*.cidr_block
}

# -> output for the __PRIVATE_SUBNETS__ IDs <-
output "private_subnets" {
  description = "Private Subnets IDs"
  value= aws_subnet.private.*.id
}

output "private_subnets_cidr" {
  description = "Private Subnets CIDR"
  value= aws_subnet.private.*.cidr_block
}

# -> output for the __INTERNET_GATEWAY__ IDs <-
output "internet_gateway" {
  description = "Internet Gateway ID"
  value= concat(aws_internet_gateway.internet_gateway.*.id, [""])[0]
}

# -> output for the __NAT_GATEWAY__ IDs <-
output "nat_gateway" {
  description = "NAT Gateway ID"
  value= concat(aws_nat_gateway.nat_gateway.*.id, [""])[0]
}

# -> output for the __ROUTE_TABLE__ IDs <-
output "route_table" {
  description = "Route Table ID"
  value= concat(aws_route_table.route_table.*.id, [""])[0]
}

# -> output for the __ROUTE_TABLE_PRIVATE__ IDs <-
output "route_table_private" {
  description = "Route Table Private ID"
  value= concat(aws_route_table.route_table_private.*.id, [""])[0]
}

# -> output for the __ROUTE_TABLE_ASSOCIATION__ IDs <-
output "route_table_association" {
  description = "Route Table Association ID"
  value= aws_route_table_association.route_table_association.*.id
}

# -> output for the __ROUTE_TABLE_ASSOCIATION_PRIVATE__ IDs <-
output "route_table_association_private" {
  description = "Route Table Association Private ID"
  value= aws_route_table_association.route_table_association_private.*.id
}

# -> output for the __SECURITY_GROUP__ IDs <-
output "security_group" {
  description = "Security Group ID"
  value= concat(aws_security_group.security_group.*.id, [""])[0]
}

# -> output for the __SECURITY_GROUP_PRIVATE__ IDs <-
output "security_group_private" {
  description = "Security Group Private ID"
  value= concat(aws_security_group.security_group_private.*.id, [""])[0]
}

# -> output for the __EC2_INSTANCE__ IDs <-
output "ec2_instance" {
  description = "EC2 Instance ID"
  value= concat(aws_instance.ec2_instance.*.id, [""])[0]
}

# -> output for the __EC2_INSTANCE_EIP__ IDs <-
output "ec2_instance_eip" {
  description = "EC2 Instance EIP ID"
  value= concat(aws_eip.ec2_instance_eip.*.id, [""])[0]
}