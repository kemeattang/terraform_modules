variable "name" {
  type        = string
  description = "Name of the EKS cluster."
}

variable "k8s_version" {
  type        = string
  description = "Version of Kubernetes to deploy."
  default     = "1.34"
}

variable "public_kube_api" {
  type        = bool
  description = "Whether to make the Kubernetes API endpoint publicly accessible."
  default     = true
}

variable "grant_admin_roles" {
  type        = bool
  description = "Whether to grant matching admin IAM roles access to the cluster."
  default     = true
}

variable "admin_role_pattern" {
  type        = string
  description = "Regex pattern for admin roles."
  default     = "AWSReservedSSO_AdministratorAccess.*"
}

variable "additional_roles" {
  description = "Additional IAM principals to grant access to the cluster. The name is kept for compatibility, but the ARN can be an IAM role or IAM user."
  type = list(object({
    role_arn   = string
    policy_arn = string
  }))
  default = []
}

variable "vpc" {
  description = "VPC configuration. If create is false, subnet values should be subnet IDs. If create is true, subnet values should be CIDR ranges."
  type = object({
    create             = bool
    vpc_id             = optional(string)
    name               = optional(string)
    cidr               = optional(string)
    private_subnets    = optional(list(string))
    public_subnets     = optional(list(string))
    intra_subnets      = optional(list(string))
    azs                = optional(list(string))
    enable_nat_gateway = optional(bool)
  })

  default = {
    create = true
  }

  validation {
    condition     = var.vpc.create == true || var.vpc.vpc_id != null
    error_message = "If VPC is not created, you must supply vpc_id."
  }

  validation {
    condition     = var.vpc.create == true || var.vpc.intra_subnets != null
    error_message = "If VPC is not created, you must supply intra subnet IDs."
  }

  validation {
    condition     = var.vpc.create == true || var.vpc.public_subnets != null
    error_message = "If VPC is not created, you must supply public subnet IDs."
  }

  validation {
    condition     = var.vpc.create == true || var.vpc.private_subnets != null
    error_message = "If VPC is not created, you must supply private subnet IDs."
  }
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create."
  type        = any

  default = {
    general-pop = {}
  }

  validation {
    condition     = length(var.eks_managed_node_groups) > 0
    error_message = "Must supply at least one managed node group to bootstrap the cluster and act as a fallback."
  }
}

variable "enable_ssm" {
  type        = bool
  description = "If true, attaches SSM policy to node group defaults."
  default     = true
}
