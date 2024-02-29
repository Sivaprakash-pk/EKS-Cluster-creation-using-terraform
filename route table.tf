resource "aws_route_table" "eks-rtb" {
  vpc_id = aws_vpc.eks-app1-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-gw.id
  }

  tags = {
    Name = "MyRoute"
  }
}

resource "aws_route_table_association" "a-1" {
  subnet_id      = aws_subnet.eks-app1-public-sub-1.id
  route_table_id = aws_route_table.eks-rtb.id
}

resource "aws_route_table_association" "a-2" {
  subnet_id      = aws_subnet.eks-app1-public-sub-2.id
  route_table_id = aws_route_table.eks-rtb.id
}