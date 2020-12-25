#!/bin/sh

minikube delete
killall -TERM kubectl minikube
minikube start --driver=virtualbox

eval $(minikube docker-env)
docker build -t my_nginx srcs/nginx
docker build -t my_mysql srcs/mysql
docker build -t my_ftps srcs/ftps

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl apply -f srcs/metalLB.yaml
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/ftps.yaml

kubectl create secret generic -n metallb-system memberlist  --from-literal=secretkey="$(openssl rand -base64 128)"

minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable ingress

minikube dashboard
