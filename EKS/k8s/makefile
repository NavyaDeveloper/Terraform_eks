describe_cluster:
        eksctl get cluster --region ap-south-1 --name mokkup-test-eks

enable_iam_sa_provider:
        eksctl utils associate-iam-oidc-provider --cluster=mokkup-test-eks --approve

create_cluster_role:
        kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.4/docs/examples/rbac-role.yaml

create_iam_policy:
        curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json
        aws iam create-policy \
                --policy-name AWSLoadBalancerControllerIAMPolicy \
                --policy-document file://iam_policy.json

create_service_account:
        eksctl create iamserviceaccount \
      --cluster=mokkup-test-eks \
      --namespace=kube-system \
      --name=aws-load-balancer-controller \
      --attach-policy-arn=arn:aws:iam::731576721364:policy/AWSLoadBalancerControllerIAMPolicy \
      --override-existing-serviceaccounts \
      --approve

deploy_cert_manager:
        kubectl apply \
    --validate=false \
    -f https://github.com/jetstack/cert-manager/releases/download/v1.12.3/cert-manager.yaml

deploy_ingress_controller:
        kubectl apply -f v2_5_4_full.yaml

deploy_application:
        kustomize build ./k8s_manifest | kubectl apply -f -

delete_application:
        kustomize build ./k8s_manifest | kubectl delete -f -