#!/bin/bash
set -e

echo "Cleaning up Kubernetes resources..."
kubectl delete -f kubernetes/ingress.yaml || true
kubectl delete -f kubernetes/service.yaml || true
kubectl delete -f kubernetes/deployment.yaml || true

echo "Cleanup completed."
