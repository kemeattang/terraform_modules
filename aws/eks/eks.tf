locals {
  vpc_id          = var.vpc.create ? module.vpc.vpc_id : var.vpc.vpc_id
  public_subnets  = var.vpc.create ? module.vpc.public_subnets : var.vpc.public_subnets
  private_subnets = var.vpc.create ? module.vpc.private_subnets : var.vpc.private_subnets
  intra_subnets   = var.vpc.create ? module.vpc.intra_subnets : var.vpc.intra_subnets

  eks_managed_node_group_list = flatten([
    for key, value in var.eks_managed_node_groups : [
      for index, subnet_id in (try(value.allow_public_subnets, false) ? concat(local.public_subnets, local.private_subnets) : local.private_subnets) :
      merge(value, {
        name       = "${key}-${index}"
        subnet_ids = [subnet_id]
      })
    ]
  ])

  eks_managed_node_groups = {
    for node_group in local.eks_managed_node_group_list : node_group.name => node_group
  }

  cluster_addons = {
    coredns = {
      most_recent = true
    }

    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent    = true
      before_compute = true
    }

    aws-ebs-csi-driver = {
      most_recent              = true
      service_account_role_arn = module.irsa_ebs_csi.iam_role_arn
    }
  }

  admin_roles = var.grant_admin_roles == false ? [] : [
    for role in data.aws_iam_roles.admin_roles.arns : {
      role_arn   = role
      policy_arn = "arn:${data.aws_partition.current.partition}:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    }
  ]
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.name
  cluster_version = var.k8s_version

  cluster_endpoint_public_access = var.public_kube_api

  cluster_addons = local.cluster_addons

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnets
  control_plane_subnet_ids = local.intra_subnets

  eks_managed_node_group_defaults = {
    iam_role_additional_policies = var.enable_ssm ? {
      SSM_ACCESS = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
    } : {}

    min_size       = 1
    max_size       = 10
    instance_types = ["t3.large"]
    capacity_type  = "ON_DEMAND"
    ami_type       = "BOTTLEROCKET_x86_64"
    platform       = "bottlerocket"
  }

  # Uses the EKS Access API instead of managing the aws-auth ConfigMap.
  access_entries = {
    for idx, entry in concat(var.additional_roles, local.admin_roles) :
    "principal-${idx}" => {
      kubernetes_groups = []
      principal_arn     = entry.role_arn

      policy_associations = {
        cluster_admin = {
          policy_arn = entry.policy_arn
          access_scope = {
            type       = "cluster"
            namespaces = []
          }
        }
      }
    }
  }

  eks_managed_node_groups = local.eks_managed_node_groups

  tags = {
    # Ensures NAT gateways are created before the EKS cluster when this module creates the VPC.
    nat_gateway_ids = var.vpc.create ? join(", ", module.vpc.natgw_ids) : ""
  }
}
