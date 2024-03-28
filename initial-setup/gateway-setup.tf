resource "aws_internet_gateway" "kubernets-igw" {
  vpc_id = aws_vpc.kubernets-vpc.id
}

resource "aws_eip" "nat-eip" {
  vpc = true
  
}
resource "aws_nat_gateway" "nat-gw" {
  subnet_id     = aws_subnet.kubernets-public-subnet[0].id
  allocation_id = aws_eip.nat-eip.id
}
