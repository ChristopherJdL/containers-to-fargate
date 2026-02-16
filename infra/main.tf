module "my_fargate" {
  source = "./modules/fargate"
  
  aws_region = var.aws_region
}