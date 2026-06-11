locals {
  vpc = {
    create             = coalesce(var.vpc.create, true)
    name               = coalesce(var.vpc.name, var.name)
    cidr               = coalesce(var.vpc.cidr, "10.0.0.0/16")
    private_subnets    = coalesce(var.vpc.private_subnets, ["10.0.0.0/21", "10.0.8.0/21", "10.0.16.0/21"])
    public_subnets     = coalesce(var.vpc.public_subnets, ["10.0.24.0/21", "10.0.32.0/21", "10.0.40.0/21"])
    enable_nat_gateway = coalesce(var.vpc.enable_nat_gateway, true)
    azs                = var.vpc.azs != null ? var.vpc.azs : data.aws_availability_zones.this.names
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  name = local.vpc.name
  cidr = local.vpc.cidr

  create_vpc = local.vpc.create

  azs             = local.vpc.azs
  private_subnets = local.vpc.private_subnets
  public_subnets  = local.vpc.public_subnets

  enable_nat_gateway = local.vpc.enable_nat_gateway
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
