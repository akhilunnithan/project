resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name_tag
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name_tag
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_1_cidr_block
  availability_zone = var.zone_1
  tags = {
    Name = "Public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_2_cidr_block
  availability_zone = var.zone_2
  tags = {
    Name = "Public_subnet_2"
  }
}

resource "aws_subnet" "private_app_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_app_subnet_1_cidr_block
  availability_zone = var.zone_1
  tags = {
    Name = "Private_app_subnet_1"
  }
}

resource "aws_subnet" "private_app_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_app_subnet_2_cidr_block
  availability_zone = var.zone_2
  tags = {
    Name = "Private_app_subnet_2"
  }
}

resource "aws_subnet" "private_db_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_db_subnet_1_cidr_block
  availability_zone = var.zone_1
  tags = {
    Name = "Private_db_subnet_1"
  }
}

resource "aws_subnet" "private_db_subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_db_subnet_2_cidr_block
  availability_zone = var.zone_2
  tags = {
    Name = "Private_db_subnet_2"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public_route_Table"
  }
}

resource "aws_route_table" "private_route_table_1" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "Private_route_Table_1"
  }
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "Private_route_Table_2"
  }
}

resource "aws_route_table_association" "public_association_1_a" {
  depends_on = [ aws_subnet.public_subnet_1, aws_route_table.public_route_table  
  ]
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_association_1_b" {
  depends_on = [ aws_subnet.public_subnet_2, aws_route_table.public_route_table  
  ]
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_association_1_a" {
  depends_on = [
    aws_subnet.private_app_subnet_1, aws_route_table.private_route_table_1
  ]
  subnet_id      = aws_subnet.private_app_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_association_2_a" {
   depends_on = [
    aws_subnet.private_db_subnet_1, aws_route_table.private_route_table_1
  ]
  subnet_id      = aws_subnet.private_db_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_association_1_b" {
  depends_on = [
    aws_subnet.private_app_subnet_2, aws_route_table.private_route_table_2
  ]
  subnet_id      = aws_subnet.private_app_subnet_2.id
  route_table_id = aws_route_table.private_route_table_2.id
}

resource "aws_route_table_association" "private_association_2_b" {
  depends_on = [
    aws_subnet.private_db_subnet_2, aws_route_table.private_route_table_2
  ]
  subnet_id      = aws_subnet.private_db_subnet_2.id
  route_table_id = aws_route_table.private_route_table_2.id
}

resource "aws_eip" "nat_public_ip_1" {
  vpc      = true
}

resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = aws_eip.nat_public_ip_1.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "Nat-gateway-1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_eip" "nat_public_ip_2" {
  vpc      = true
}

resource "aws_nat_gateway" "nat_gateway_2" {
  allocation_id = aws_eip.nat_public_ip_2.id
  subnet_id     = aws_subnet.public_subnet_2.id

  tags = {
    Name = "Nat-gateway-2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route" "private_aws_route_1" {
  depends_on = [
    aws_route_table.private_route_table_1, aws_nat_gateway.nat_gateway_1
  ]
  route_table_id              = aws_route_table.private_route_table_1.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.nat_gateway_1.id
}

resource "aws_route" "private_aws_route_2" {
  depends_on = [
    aws_route_table.private_route_table_2, aws_nat_gateway.nat_gateway_2
  ]
  route_table_id              = aws_route_table.private_route_table_2.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.nat_gateway_2.id
}