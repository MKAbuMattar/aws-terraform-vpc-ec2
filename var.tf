# variables
variable "environment" {
  description = "Environment name"
  type = string
  default = "devlopment"
}

# -> variables for the __VPC__ module <-
variable "vpc_created" {
  description = "Whether to create a VPC or not"
  type = bool
  default = true
}

variable "vpc_name" {
  description = "Name of the VPC"
  type = string
  default = "vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames in the VPC"
  type = bool
  default = true
}

variable "vpc_enable_dns_support" {
  description = "Whether to enable DNS support in the VPC"
  type = bool
  default = true
}

# -> variables for the __PUBLIC_SUBNETS__ module <-
variable "public_subnets_created" {
  description = "Whether to create public subnets or not"
  type = bool
  default = true
}

variable "public_subnets_names" {
  description = "Names of the public subnets"
  type = string
  default = "public_subnet"
}

variable "public_subnets_cidr" {
  description = "CIDR blocks for the public subnets"
  type = string
  default = "10.0.0.0/24"
}

variable "public_subnets_azs" {
  description = "Availability zones for the public subnets"
  type = string
  default = "us-east-1a"
}

variable "public_subnets_map_public_ip_on_launch" {
  description = "Whether to map public IP on launch for the public subnets"
  type = bool
  default = true
}

# -> variables for the __PRIVATE_SUBNETS__ module <-
variable "private_subnets_created" {
  description = "Whether to create private subnets or not"
  type = bool
  default = true
}

variable "private_subnets_names" {
  description = "Names of the private subnets"
  type = string
  default = "private_subnet"
}

variable "private_subnets_cidr" {
  description = "CIDR blocks for the private subnets"
  type = string
  default = "10.0.16.0/24"
}

variable "private_subnets_azs" {
  description = "Availability zones for the private subnets"
  type = string
  default = "us-east-1a"
}

variable "private_subnets_map_public_ip_on_launch" {
  description = "Whether to map public IP on launch for the private subnets"
  type = bool
  default = false
}

# -> variables for the __INTERNET_GATEWAY__ module <-
variable "internet_gateway_created" {
  description = "Whether to create an internet gateway or not"
  type = bool
  default = true
}

variable "internet_gateway_name" {
  description = "Name of the internet gateway"
  type = string
  default = "internet_gateway"
}

# -> variables for the __NAT_EIP__ module <-
variable "nat_eip_created" {
  description = "Whether to create an EIP for the NAT gateway or not"
  type = bool
  default = true
}

variable "nat_eip_name" {
  description = "Name of the EIP for the NAT gateway"
  type = string
  default = "nat_eip"
}

# -> variables for the __NAT_GATEWAY__ module <-
variable "nat_gateway_created" {
  description = "Whether to create a NAT gateway or not"
  type = bool
  default = true
}

variable "nat_gateway_name" {
  description = "Name of the NAT gateway"
  type = string
  default = "nat_gateway"
}

# -> variables for the __PUBLIC_ROUTE_TABLE__ module <-
variable "public_route_table_created" {
  description = "Whether to create a public route table or not"
  type = bool
  default = true
}

variable "public_route_table_name" {
  description = "Name of the public route table"
  type = string
  default = "public_route_table"
}

# -> variables for the __PUBLIC_ROUTE_TABLE_ASSOCIATION__ module <-
variable "public_route_table_association_created" {
  description = "Whether to create a public route table association or not"
  type = bool
  default = true
}

variable "public_route_table_association_name" {
  description = "Name of the public route table association"
  type = string
  default = "public_route_table_association"
}

# -> variables for the __PRIVATE_ROUTE_TABLE__ module <-
variable "private_route_table_created" {
  description = "Whether to create a private route table or not"
  type = bool
  default = true
}

variable "private_route_table_name" {
  description = "Name of the private route table"
  type = string
  default = "private_route_table"
}

# -> variables for the __PRIVATE_ROUTE_TABLE_ASSOCIATION__ module <-
variable "private_route_table_association_created" {
  description = "Whether to create a private route table association or not"
  type = bool
  default = true
}

variable "private_route_table_association_name" {
  description = "Name of the private route table association"
  type = string
  default = "private_route_table_association"
}

# -> variables for the __SECURITY_GROUP__ module <-
variable "security_group_created" {
  description = "Whether to create a security group or not"
  type = bool
  default = true
}

variable "security_group_name" {
  description = "Name of the security group"
  type = string
  default = "security_group"
}

variable "security_group_description" {
  description = "Description of the security group"
  type = string
  default = "Security group for the VPC"
}

# -> variables for the __SECURITY_GROUP_INGRESS_RULES__ module <-
variable "security_group_ingress_rules_created" {
  description = "Whether to create ingress rules for the security group or not"
  type = bool
  default = true
}

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

# -> variables for the __EC2_INSTANCE__ module <-
variable "ec2_instance_created" {
  description = "Whether to create an EC2 instance or not"
  type = bool
  default = true
}

variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  type = string
  default = "ec2_instance"
}

variable "ec2_instance_ami" {
  description = "AMI for the EC2 instance"
  type = string
  default = "ami-0b0dcb5067f052a63"
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance"
  type = list(string)
  default = ["t1.micro", "t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large", "t2.xlarge", "t2.2xlarge", "t3.nano", "t3.micro", "t3.small", "t3.medium", "t3.large", "t3.xlarge", "t3.2xlarge", "t3a.nano", "t3a.micro", "t3a.small", "t3a.medium", "t3a.large", "t3a.xlarge", "t3a.2xlarge"]
}

variable "ec2_instance_key_name" {
  description = "Key name for the EC2 instance"
  type = string
  default = "ec2_key_pair"
}

variable "ec2_instance_associate_public_ip_address" {
  description = "Whether to associate a public IP address with the EC2 instance or not"
  type = bool
  default = true
}

# -> variables for the __EC2_INSTANCE_EIP__ module <-
variable "ec2_instance_eip_created" {
  description = "Whether to create an EIP for the EC2 instance or not"
  type = bool
  default = true
}

variable "ec2_instance_eip_name" {
  description = "Name of the EIP for the EC2 instance"
  type = string
  default = "ec2_instance_eip"
}

# -> variables for the __EC2_INSTANCE_EIP_ASSOCIATION__ module <-
variable "ec2_instance_eip_association_created" {
  description = "Whether to create an EIP association for the EC2 instance or not"
  type = bool
  default = true
}