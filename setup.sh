#!/bin/sh

minikube delete

#Starting minikube and setting virtualbox as
minikube start --driver=virtualbox

#Setting propper environment variables to use docker daemon
eval $(minikube docker-env)

docker build -t my_nginx srcs/nginx
docker build -t my_ftps srcs/ftps

#Installing and configuring metallb by the manifest
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
#kubectl apply -f https://raw.githubusercontent.com/mvallim/kubernetes-under-the-hood/master/metallb/metallb-config.yaml
kubectl apply -f srcs/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/ftps.yaml

minikube dashboard
