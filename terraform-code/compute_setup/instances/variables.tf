variable "ami_id" {
  type = string
  description = "The ami id to be used"
  default = "ami-09d3b3274b6c5d4aa" #us-east-1
}

variable "instance_type" {
  type = string
  description = "The instance type to be usedd "
  default = "t2.micro"
}

variable "vpc_id" {
  type = string
  description = "The id of the VPC "
  default = "vpc-0776cec224fe1dc9d"
}

variable "zone_1" {
  type = string
  description = "The availibility zone 1 "
  default = "us-east-1a"
}

variable "zone_2" {
  type = string
  description = "The availibility zone 2 "
  default = "us-east-1b"
}

variable "public_subnet_1_id" {
  type = string
  description = "Id of public subnet 1 "
  default = "subnet-06e705eeda6ecf3ba"
}

variable "public_subnet_2_id" {
  type = string
  description = "Id of public subnet 2 "
  default = "subnet-0e982cbaefa9bdf2b"
}

variable "private_app_subnet_1_id" {
  type = string
  description = "Id of private app subnet 1 "
  default = "subnet-0114187491425ad85"
}

variable "private_app_subnet_2_id" {
  type = string
  description = "Id of private app subnet 2 "
  default = "subnet-040d4f78b45c80b87"
}

variable "private_db_subnet_1_id" {
  type = string
  description = "Id of private database subnet 1 "
  default = "subnet-0f452e651fa4c4623"
}

variable "private_db_subnet_2_id" {
  type = string
  description = "Id of private database subnet 2 "
  default = "subnet-0c8884ce79b7d18ba"
}




