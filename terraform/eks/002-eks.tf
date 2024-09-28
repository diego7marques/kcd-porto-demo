module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.24.2"
  cluster_name    = "k8gb-kcdporto-aws"
  cluster_version = "1.30"

  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id
  enable_irsa     = true

  authentication_mode = "API_AND_CONFIG_MAP"

  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 1
      max_capacity     = 1
      min_capacity     = 1
      instance_type    = "t3.micro"
      disk_size        = 20

      additional_tags = {
        Name        = "k8gb-kcdporto-worker-node"
      }
    }
  }

  cluster_endpoint_public_access  = true
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
}

module "iam_assumable_role_admin" {
  source                        = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version                       = "5.44.0"
  create_role                   = true
  role_name                     = "external-dns-k8gb"
  provider_url                  = replace(module.eks.cluster_oidc_issuer_url, "https://", "")
  role_policy_arns              = [aws_iam_policy.external_dns_route53.arn]
  oidc_fully_qualified_subjects = ["system:serviceaccount:k8gb:k8gb-external-dns"]
}

resource "aws_iam_policy" "external_dns_route53" {
  name        = "AllowExternalDNSUpdatesForK8gb"
  description = "Enable external-dns to update Route53"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": [
                "arn:aws:route53:::hostedzone/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ListHostedZones",
                "route53:ListResourceRecordSets"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}