
locals {
  number_of_public_subnet = 2
  number_of_private_subnet = 2
}

resource "aws_vpc" "kubernets-vpc" {
 cidr_block = var.vpc_cidr
 
 
 tags = {
   Name = "kubernets-VPC"
 }
  lifecycle {
   ignore_changes = [ tags ]
 }
}
resource "aws_subnet" "kubernets-public-subnet" {
  vpc_id     = aws_vpc.kubernets-vpc.id
  cidr_block = var.public_subnet[count.index]
  map_public_ip_on_launch=true
  


  tags = {
    Name = "public-subnet"
  }
  count = local.number_of_public_subnet

    lifecycle {
   ignore_changes = [ tags ]
 }
}
resource "aws_subnet" "kubernets-private-subnet" {
  vpc_id     = aws_vpc.kubernets-vpc.id
  cidr_block = var.private_subnet[count.index]
  map_public_ip_on_launch=false
  

  tags = {
    Name = "private-subnet"
  }
  count = local.number_of_private_subnet

    lifecycle {
   ignore_changes = [ tags ]
 }
}

resource "aws_route_table" "kubernets-public-route-table" {
  vpc_id = aws_vpc.kubernets-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kubernets-igw.id
  }
  
  tags = {
    Name = "kubernets-public-rote-table"
  }
}
resource "aws_route_table_association" "public-route-table-assoc" {
  subnet_id      = aws_subnet.kubernets-public-subnet[count.index].id
  route_table_id = aws_route_table.kubernets-public-route-table.id
  count = local.number_of_public_subnet
}

resource "aws_route_table" "kubernets-private-route-table" {
  vpc_id = aws_vpc.kubernets-vpc.id


  route {
    cidr_block        = "0.0.0.0/0"
    nat_gateway_id =  aws_nat_gateway.nat-gw.id
  }
  
  tags = {
    Name = "kubernets-private-rote-table"
  }
   lifecycle {
   ignore_changes = [ tags ]
 }
 
}

resource "aws_route_table_association" "kubernets_rt-aws_route_table_association" {
  subnet_id      = aws_subnet.kubernets-private-subnet[count.index].id
  route_table_id = aws_route_table.kubernets-private-route-table.id
  count = local.number_of_private_subnet
}


output "vpc-id" {
  value = aws_vpc.kubernets-vpc.id
}

output "public-subnet" {
  value = aws_subnet.kubernets-public-subnet[*].id
}

output "private-subnet" {
  value = aws_subnet.kubernets-private-subnet[*].id
}


output "public-route-table" {
  value = aws_route_table.kubernets-public-route-table.id
}

output "private-route-table" {
  value = aws_route_table.kubernets-private-route-table.id
}


