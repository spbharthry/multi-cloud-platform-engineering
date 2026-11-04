module "network" {
  source               = "../../../modules/aws/network"
  name                 = "portfolio-dev-aws"
  vpc_cidr             = "10.10.0.0/16"
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnet_cidrs = ["10.10.11.0/24", "10.10.12.0/24"]
  tags                 = { Environment = "dev", Project = "multi-cloud-platform-engineering", Owner = "portfolio" }
}
output "vpc_id" { value = module.network.vpc_id }
