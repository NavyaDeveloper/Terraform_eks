pipeline{
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY_ID')
        AWS_DEFAULT_REGION = "us-east-1"
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

        stage("Formatting Terraform"){
            steps{
                script{
                   dir('EKS'){
                    sh 'terraform fmt'
                   }
                }
            }
        }

        stage("Validating Terraform"){
            steps{
                script{
                   dir('EKS'){
                    sh 'terraform validate'
                   }
                }
            }
        }

        stage("Planning Terraform"){
            steps{
                script{
                   dir('EKS'){
                    sh 'terraform plan'
                   }
                   input(message: "Are You sure to proceed?", ok: "Proceed")
                }
            }
        }

        stage("Applying/Destroying Terraform"){
            steps{
                script{
                   dir('EKS'){
                    sh 'terraform $action --auto-approve'
                   }
                }
            }
        }

        stage("Deploying services"){
            steps{
                script{
                   dir('EKS/k8s/k8s_manifest'){
                        sh 'aws eks update-kubeconfig --name eks_test'
                        sh 'kubectl apply -f auth-deployment.yml'
                        sh 'kubectl apply -f blog-deployment.yml'
                        sh 'kubectl apply -f dashboard-deployment.yml'
                   }
                }
            }
        }

    }
}