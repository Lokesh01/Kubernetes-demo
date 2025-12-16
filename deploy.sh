set -e

NAME="kubernetes-demo-api"
USERNAME="negi01"
IMAGE="$USERNAME/$NAME:latest"

echo "Building Docker image..."
docker build -t $IMAGE .

echo "Pushing Docker image to Docker Hub..."
docker push $IMAGE

echo "Applying Kubernetes configurations..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "getting pods"
kubectl get pods

echo "getting services"
kubectl get services

echo "getting the main service details"
kubectl get services $NAME-service

echo "Deployment completed."