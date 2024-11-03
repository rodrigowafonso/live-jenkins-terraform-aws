pipeline {

    agent any

    stages {

        stage ("Checkout Source") {
            steps {
                git url: 'https://github.com/rodrigowafonso/live-jenkins-terraform-aws.git', branch: 'main'
                sh 'ls -la'
            }
        }

        stage ("Execução da Projeto Terraform") {
            environment {
                AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
                AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
                AWS_REGION = credentials('AWS_REGION')
                AWS_NAME_BUCKET = credentials('AWS_NAME_BUCKET')
                AWS_TERRAFORM_TFSTATE = credentials('AWS_TERRAFORM_TFSTATE')
            }
            steps {
                script {
                    dir('src') {
                        sh 'terraform init -backend-config="bucket=$AWS_NAME_BUCKET" -backend-config="key=$AWS_TERRAFORM_TFSTATE"'
                        sh 'terraform apply --auto-approve'
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }
}