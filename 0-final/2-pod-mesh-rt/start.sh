#!/bin/bash
echo "Update context"
echo "-------------------------------"
aws eks update-kubeconfig --name appmesh-cluster

echo "Run oidc"
echo "-------------------------------" 
eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=appmesh-cluster --approve


echo "Clearing old iam policies and roles"
echo "------------------------------------"
eksctl delete iamserviceaccount --cluster appmesh-cluster  --name appmesh-controller-sa --namespace appmesh-system

echo "Delete envoy service account"
echo "------------------------------------"
eksctl delete iamserviceaccount --cluster appmesh-cluster  --name envoy-proxy-sa  --namespace appmesh-system


echo "Delete app mesh namespace"
echo "------------------------------------"
helm delete appmesh-controller-sa -n appmesh-system

echo "Delete app mesh namespace"
echo "------------------------------------"
helm delete appmesh-controller -n appmesh-system
kubectl delete ns appmesh-system

#load balancer 
echo "uninstall LB"
echo "-------------------------------"
helm uninstall aws-load-balancer-controller aws-load-balancer-controller -n kube-system 


echo "Delete LB service account"
echo "-------------------------------"
  eksctl delete iamserviceaccount \
  --cluster=appmesh-cluster\
  --namespace=kube-system \
  --name=aws-load-balancer-controller-sa

echo "add helm repo"
echo "----------------------------------------"
helm repo add eks https://aws.github.io/eks-charts

echo "Create the app mesh namespace"
echo "-------------------------------"
kubectl create ns appmesh-system

echo "create appmesh controller sa with managed policy"
echo "-------------------------------"
eksctl create iamserviceaccount --cluster appmesh-cluster \
 --name appmesh-controller-sa \
 --attach-policy-arn arn:aws:iam::aws:policy/AWSAppMeshFullAccess \
 --override-existing-serviceaccounts --namespace appmesh-system \
  --approve

echo "install appmesh controller"
echo "-------------------------------"
helm install appmesh-controller eks/appmesh-controller \
 --namespace appmesh-system \
 --set region=us-east-1 \
 --set serviceAccount.create=false \
 --set serviceAccount.name=appmesh-controller-sa

aws iam create-policy \
    --policy-name AWSAppMeshEnvoyIAMPolicy \
    --policy-document file://envoy-iam-policy.json

echo "create appmesh envoy sa"
echo "-------------------------------"
eksctl create iamserviceaccount --cluster appmesh-cluster \
    --namespace appmesh-system \
    --name envoy-proxy-sa \
    --attach-policy-arn arn:aws:iam::826597467339:policy/AWSAppMeshEnvoyIAMPolicy  \
    --override-existing-serviceaccounts \
    --approve

eksctl create iamserviceaccount \
  --cluster=appmesh-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller-sa \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::826597467339:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=appmesh-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller-sa

echo "Install the App Mesh CRDs:"
echo "--------------------------"
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"

echo "--------------output-----------------"
kubectl -n appmesh-system get all