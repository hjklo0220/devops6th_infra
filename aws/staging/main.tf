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

module "be-server" {
  source = "../modules/server"

  env = local.env
  name = "be"
  vpc_id = module.network.vpc_id
  subnet_id = module.network.subnet_id
  init_script_path = "be_init_script.tftpl"
  init_script_envs = {
    password = var.password
    POSTGRES_DB = var.POSTGRES_DB
    POSTGRES_USER = var.POSTGRES_USER
    POSTGRES_PASSWORD = var.POSTGRES_PASSWORD
    POSTGRES_PORT = var.POSTGRES_PORT
    DJANGO_SETTINGS_MODULE = var.DJANGO_SETTINGS_MODULE
    DJANGO_SECRET_KEY = var.DJANGO_SECRET_KEY
    DB_HOST = module.db-server.public_ip
    NCP_ACCESS_KEY = var.NCP_ACCESS_KEY
    NCP_SECRET_KEY = var.NCP_SECRET_KEY
  }
  port_range = 8000
}

module "lb" {
  source = "../modules/lb"

  env = local.env
  vpc_id = module.network.vpc_id
  subnet_id = module.network.subnet_id
  instance_id = module.be-server.instance_id
}
