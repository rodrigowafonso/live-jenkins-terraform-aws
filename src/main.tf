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
