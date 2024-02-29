resource "aws_instance" "kubectl-server" {
  ami                         = "ami-0c7217cdde317cfec"
  key_name                    = "us-nv-key"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.eks-app1-public-sub-1.id
  vpc_security_group_ids      = [aws_security_group.eks-app1-sg.id]

  tags = {
    Name = "kubectl"
  }

}

resource "aws_eks_node_group" "node-grp" {
  cluster_name    = aws_eks_cluster.eks-app1.name
  node_group_name = "pc-node-group"
  node_role_arn   = aws_iam_role.eks-worker.arn
  subnet_ids      = [aws_subnet.eks-app1-public-sub-1.id, aws_subnet.eks-app1-public-sub-2.id]
  capacity_type   = "ON_DEMAND"
  disk_size       = "20"
  instance_types  = ["t2.small"]

  remote_access {
    ec2_ssh_key               = "us-nv-key"
    source_security_group_ids = [aws_security_group.eks-app1-sg.id]
  }

  labels = tomap({ env = "dev" })

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    #aws_subnet.eks-app1-public-sub-1,
    #aws_subnet.eks-app1-public-sub-2,
  ]
}