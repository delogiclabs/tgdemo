include {
  path = find_in_parent_folders()
}

locals {
  environment = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  project = read_terragrunt_config(find_in_parent_folders("project.hcl"))
}

terraform {
  source = "..///"
}

inputs = {
  vpc_id    = "vpc-0661e9f07be563a57"
  sg_prefix = "${local.project.locals.project}-${local.environment.locals.environment}-elasticsearch"

  tags = merge(
    local.project.locals.tags,
    {
    Environment = "${local.environment.locals.environment}"
    Project     = "${local.project.locals.project}"
  })
}
