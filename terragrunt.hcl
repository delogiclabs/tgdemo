locals {
  region = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket  = "tgdm-terragrunt-state"
    region  = local.region.locals.region
    key     = "${path_relative_to_include()}/terraform.tfstate"
  }
  generate = {
    path      = "terragrunt_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_version = "0.13.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.64.2"
    }
  }
}

provider "aws" {
  region  = "${local.region.locals.region}"
  profile = "${local.region.locals.profile}"
}
EOF
}
