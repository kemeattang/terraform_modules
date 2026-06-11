output "eks" {
  value = module.eks
}

output "irsa_cluster_autoscaler" {
  value = module.irsa_cluster_autoscaler
}

output "irsa_load_balancer_controller" {
  value = module.irsa_load_balancer_controller
}

output "irsa_ebs_csi" {
  value = module.irsa_ebs_csi
}

output "vpc" {
  value = var.vpc.create ? module.vpc : null
}
