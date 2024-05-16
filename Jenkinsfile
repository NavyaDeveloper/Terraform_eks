pipeline{
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY_ID')
        AWS_DEFAULT_REGION = "us-east-1"
    }
       
    stages{
        stage("checkout11"){
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

        stage("Installing tools"){
            steps{
                script{
                    dir('EKS/k8s'){
                        sh 'make eksctl'
                        sh 'make eksctl_mv'
                    }
                       withCredentials([usernamePassword(credentialsId: 'dockerhub_cred', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
      sh 'kubectl create secret docker-registry reg-cred --docker-server=docker.io --docker-username=$DOCKER_USERNAME --docker-password=$DOCKER_PASSWORD --docker-email=navya.animone@neenopal.com'      
}
                        
                }
            }
        }

        stage("makes"){
            steps{
                script{
                   dir('EKS/k8s'){
                        sh 'sudo make enable_iam_sa_provider'
                        sh 'sudo make create_cluster_role'
                        sh 'sudo make create_iam_policy'
                        sh 'sudo make create_service_account'
                        sh 'sudo make deploy_cert_manager'
                   }
                }
            }
        }

        stage("setting makefile"){
            steps{
                script{
                        sh 'sudo curl -Lo v2_5_4_full.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.5.4/v2_5_4_full.yaml'
                        sh 'sudo sed -i.bak -e "596,604d" ./v2_5_4_full.yaml'
                        sh 'sudo sed -i.bak -e "s|your-cluster-name|my-cluster|" ./v2_5_4_full.yaml'
                        sh 'sudo kubectl apply -f v2_5_4_full.yaml'
                        sh 'sudo curl -Lo v2_5_4_ingclass.yaml https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.5.4/v2_5_4_ingclass.yaml'
                        sh 'sudo kubectl apply -f v2_5_4_ingclass.yaml'
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
                        sh 'kubectl apply -f ingress.yml'
                   }
                }
            }
        }

    }
}
