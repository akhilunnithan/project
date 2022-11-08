variable "vpc_cidr_block" {
  type = string
  description = "VPC CIDR range"
  default = "10.0.0.0/16"
}

variable "vpc_name_tag" {
  type = string
  description = "Name tag of the VPC"
  default = "akhil"
}

variable "igw_name_tag" {
  type = string
  description = "Internet Gateway name tag"
  default = "akhil-gw"
}

variable "public_subnet_1_cidr_block" {
  type = string
  description = "Cidr block for public subnet 1"
  default = "10.0.1.0/24"
}

variable "zone_1" {
  type = string
  description = "availability zone one"
  default = "us-east-1a"
}

variable "public_subnet_2_cidr_block" {
  type = string
  description = "Cidr block for public subnet 2"
  default = "10.0.2.0/24"
}

variable "zone_2" {
  type = string
  description = "availability zone two"
  default = "us-east-1b"
}

variable "private_app_subnet_1_cidr_block" {
  type = string
  description = "Cidr block for private app subnet 1"
  default = "10.0.3.0/24"
}

variable "private_app_subnet_2_cidr_block" {
  type = string
  description = "Cidr block for private app subnet 2"
  default = "10.0.4.0/24"
}

variable "private_db_subnet_1_cidr_block" {
  type = string
  description = "Cidr block for private Database subnet 1"
  default = "10.0.5.0/24"
}

variable "private_db_subnet_2_cidr_block" {
  type = string
  description = "Cidr block for private Database subnet 2"
  default = "10.0.6.0/24"
}


