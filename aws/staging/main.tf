terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-2"
}

locals {
  env = "staging"
}

module "network" {
  source = "../modules/network"

  env = local.env
}

module "db-server" {
  source = "../modules/server"

  env = local.env
  name = "db"
  vpc_id = module.network.vpc_id
  subnet_id = module.network.subnet_id
  init_script_path = "db_init_script.tftpl"
  init_script_envs = {
    password = var.password
    POSTGRES_DB = var.POSTGRES_DB
    POSTGRES_USER = var.POSTGRES_USER
    POSTGRES_PASSWORD = var.POSTGRES_PASSWORD
    POSTGRES_PORT = var.POSTGRES_PORT
  }
  port_range = 5432
}
