output "vpc_id" {
  value = aws_vpc.main.id
  description="The id of the created VPC"
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
  description="The id of public subnet 1"
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
  description="The id of public subnet 2"
}

output "private_app_subnet_1_id" {
  value = aws_subnet.private_app_subnet_1.id
  description="The id of private app subnet 1"
}

output "private_app_subnet_2_id" {
  value = aws_subnet.private_app_subnet_2.id
  description="The id of private app subnet 2"
}

output "private_db_subnet_1_id" {
  value = aws_subnet.private_db_subnet_1.id
  description="The id of private db subnet 1"
}

output "private_db_subnet_2_id" {
  value = aws_subnet.private_db_subnet_2.id
  description="The id of private db subnet 2"
}
