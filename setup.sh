#export MINIKUBE_HOME=/goinfre/$(whoami)
minikube delete

# Use virtualbox as kubernetes driver
minikube start --driver=docker

# Setting propper environment variables for docker in kubernetes.
eval $(minikube docker-env)

docker build -t my_nginx srcs/nginx
docker build -t my_ftps srcs/ftps
docker build -t my_grafana srcs/grafana
docker build -t my_influxdb srcs/influxdb
docker build -t my_wordpress srcs/wordpress
docker build -t my_mysql srcs/mysql
docker build -t my_phpmyadmin srcs/phpmyadmin

#Installing and configuring metallb by manifest
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist  --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f srcs/metalLB.yaml

kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/grafana.yaml
kubectl apply -f srcs/influxdb.yaml
kubectl apply -f srcs/wordpress.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/phpmyadmin.yaml

minikube addons enable dashboard
minikube addons enable metrics-server
minikube addons enable ingress

# Open dashboard.
minikube dashboard
