variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "init_script_path" {
  type = string
}

variable "init_script_envs" {
  type = map(any)
}

variable "port_range" {
  type = number
}

