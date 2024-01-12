pipeline{
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY_ID')
        region = "us-east-1"
    }
       
    stages{
        stage("checkout"){
            steps{
                script{
                   checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/NavyaDeveloper/Terraform_eks.git']])
                }
            }
        }

        stage("Initializing Terraform"){
            steps{
                script{
                   dir('EKS'){
                    sh 'terraform init'
                   }
                }
            }
        }

        
    }
}