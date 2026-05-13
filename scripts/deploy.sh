#!/bin/bash
set -e

IMAGE=$1
if [ -z "$IMAGE" ]; then
  echo "Error: Image name not provided."
  exit 1
fi

echo "Deploying image $IMAGE..."
# Substitute image name in deployment.yaml
sed -e "s|\${IMAGE_NAME}|$IMAGE|g" kubernetes/deployment.yaml > kubernetes/deployment-applied.yaml

kubectl apply -f kubernetes/deployment-applied.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/ingress.yaml

echo "Waiting for deployment to complete..."
kubectl rollout status deployment/fintech-app -n default --timeout=120s

echo "Deployment successful."
