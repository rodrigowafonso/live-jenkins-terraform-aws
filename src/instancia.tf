# Garantindo que será utilizado a Key Pair Devops Rodrigo Afonso
data "aws_key_pair" "rwa_chave_tj" {
  key_name = var.key_pair_nome
}
  
# Provisionando a Instancia AWS
resource "aws_instance" "rwa_ec2_tj" {
  ami = var.ec2_imagem_instancia
  instance_type = var.ec2_tipo_instancia
  key_name = data.aws_key_pair.rwa_chave_tj.key_name
  subnet_id = aws_subnet.rwa_subnet_tj.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.rwa_sg_tj.id]

  tags = {
    Name = "srv-pipeline-tj"
  }
  
  provisioner "remote-exec" {
    inline = [ 
        "sudo apt update -y",
        "sudo apt install nginx -y",
        "sudo systemctl start nginx",
        "sudo systemctl enable nginx",
        "sudo systemctl status nginx"
    ]
    
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/key_devops_rodrigoafonso.pem")
      host = self.public_ip
    }
  }
  
  }



# Informando o IP Público da Instância
output "public_ip" {
  value = aws_instance.rwa_ec2_tj.public_ip
}

# Informando o Endpoint da Instância
output "endpoint" {
  description = "DNS da Instância"
  value = aws_instance.rwa_ec2_tj.public_dns
}