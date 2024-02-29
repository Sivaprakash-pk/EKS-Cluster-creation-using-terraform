resource "aws_eks_cluster" "eks-app1" {
  name     = "pc-eks-app1"
  role_arn = aws_iam_role.eks-master.arn


  vpc_config {
    subnet_ids = [aws_subnet.eks-app1-public-sub-1.id, aws_subnet.eks-app1-public-sub-2.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    #aws_subnet.eks-app1-public-sub-1,
    #aws_subnet.eks-app1-public-sub-2,
  ]

}