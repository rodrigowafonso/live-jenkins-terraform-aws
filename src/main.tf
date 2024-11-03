terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "4.56.0"
        }
    }
    backend "s3" {
      # Definir as variáveis de ambiente no Jenkins
    }
}

# Definindo o Provider
provider "aws" {
    region = var.aws_region
}

# Provisionando a VPC 
resource "aws_vpc" "rwa_vpc_tj" {
    cidr_block = var.vpc_cidr_block
    tags = {
      Name = var.vpc_nome
    }
}

# Provisionando a Subnet
resource "aws_subnet" "rwa_subnet_tj" {
  vpc_id = aws_vpc.rwa_vpc_tj.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.subnet_availability_zone

  tags = {
    Name = var.subnet_nome
  }
}

# Provisionando o Internet Gateway
resource "aws_internet_gateway" "rwa_gw_tj" {
  tags = {
    Name = var.internet_gateway_nome
  }
}

# Garantindo que o Internet Gateway seja associado a VPC
resource "aws_internet_gateway_attachment" "rwa_gw_vpc_tj" {
  internet_gateway_id = aws_internet_gateway.rwa_gw_tj.id
  vpc_id = aws_vpc.rwa_vpc_tj.id
}

# Provisionando a Route Table
resource "aws_route_table" "rwa_rt_nome" {
  vpc_id = aws_vpc.rwa_vpc_tj.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rwa_gw_tj.id
  }

  tags = {
    Name = var.route_table_nome
  }
}

# Garantindo que a Tabela de Rota estaja associada a Subnet
resource "aws_route_table_association" "rwa_rt_atachar" {
  subnet_id = aws_subnet.rwa_subnet_tj.id
  route_table_id = aws_route_table.rwa_rt_nome.id
}

# Provisionando o Security Group
resource "aws_security_group" "rwa_sg_tj" {
  name = "rwa_sg_tj"
  description = "Permitir o trafego de tudo"
  vpc_id = aws_vpc.rwa_vpc_tj.id

  tags = {
    Name = "rwa_sg_tj"
  }
}

# Garantindo que o Inbound esteja liberado para todos
resource "aws_security_group_rule" "rwa_sg_ingress_tj" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  security_group_id = aws_security_group.rwa_sg_tj.id
}

# Garantindo que o Outbound esteja liberado para todos
resource "aws_security_group_rule" "rwa_sg_egress_tj" {
  type = "egress"
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
  security_group_id = aws_security_group.rwa_sg_tj.id
}

