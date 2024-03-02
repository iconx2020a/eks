module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway     = true
  single_nat_gateway     = true
  
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  one_nat_gateway_per_az = false

  # Make EKS nodes public. 
  map_public_ip_on_launch = true

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"               = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb"                        = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}

module "platform" {
  source = "../platform"
  private_subnets_id = module.vpc.private_subnets
  public_subnets_id = module.vpc.public_subnets
  instance_types = var.instance_types
 
}
