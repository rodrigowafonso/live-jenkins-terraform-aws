variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "vpc_cidr_block" {
  type = string
  default = "192.168.0.0/16"
}

variable "vpc_nome" {
  type = string
  default = "rwa-vpc-tj"
}

variable "subnet_nome" {
  type = string
  default = "rwa-subnet-tj"
}

variable "subnet_cidr_block" {
  type = string
  default = "192.168.1.0/24"
}

variable "subnet_availability_zone" {
  type = string
  default = "us-east-1a"
}

variable "internet_gateway_nome" {
  type = string
  default = "rwa-gw-tj"
}

variable "route_table_nome" {
  type = string
  default = "rwa-rt-tj"
}

variable "key_pair_nome" {
  type = string
  default = "key_devops_rodrigoafonso"
}

variable "ec2_instancia_nome" {
  type = string
  default = "srv-pipeline-tj"
}

variable "ec2_imagem_instancia" {
  type = string
  default = "ami-0866a3c8686eaeeba"
}

variable "ec2_tipo_instancia" {
  type = string
  default = "t2.micro"
}