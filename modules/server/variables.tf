variable "NCP_ACCESS_KEY" {
  type = string
}

variable "NCP_SECRET_KEY" {
  type = string
}

variable "env" {
  type = string
}

variable "name" {
  type = string
}

variable "subnet_no" {
  type = string
}

variable "server_image_product_code" {
  type = string
}

variable "product_code" {
  type = string
}

variable "init_script_path" {
  type = string
}

variable "init_script_envs" {
  type = map(any)
}

variable "vpc_no" {
  type = string
}

variable "acg_port_range" {
  type = string
}
