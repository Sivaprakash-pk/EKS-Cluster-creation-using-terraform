resource "aws_internet_gateway" "eks-gw" {
  vpc_id = aws_vpc.eks-app1-vpc.id

  tags = {
    Name = "eks-app1-vpc"
  }
}