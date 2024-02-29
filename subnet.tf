resource "aws_subnet" "eks-app1-public-sub-1" {
  vpc_id                  = aws_vpc.eks-app1-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-sub-1"
  }
}

resource "aws_subnet" "eks-app1-public-sub-2" {
  vpc_id                  = aws_vpc.eks-app1-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-sub-2"
  }
}