minikube delete
killall -TERM kubectl minikube
minikube start --driver=docker

eval $(minikube docker-env)
docker build -t my_nginx srcs/nginx > /dev/null 2>&1

kubectl apply -f srcs/nginx.yaml
