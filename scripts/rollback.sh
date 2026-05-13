#!/bin/bash
set -e

echo "Rolling back deployment..."
kubectl rollout undo deployment/fintech-app -n default

echo "Waiting for rollback to complete..."
kubectl rollout status deployment/fintech-app -n default --timeout=120s

echo "Rollback successful."
