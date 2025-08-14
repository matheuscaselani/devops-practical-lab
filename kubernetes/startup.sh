#!/usr/bin/env bash
set -euxo pipefail

# Start Colima with Docker runtime and minimal resources
colima start --cpu 2 --memory 2 --disk 10 --runtime docker

# Ensure Docker CLI is using Colima's context
docker context use colima

# Start Minikube using the Docker (Colima) driver
minikube start --driver=docker --kubernetes-version=stable

# Build the local container image and load it into the local Docker daemon
docker-buildx inspect >/dev/null 2>&1 || docker-buildx create --use
docker-buildx build -t idwall-test:latest . --no-cache --load

# Load the image into Minikube's container runtime
minikube image load idwall-test:latest --overwrite

# Deploy the Helm chart (wait for resources to become ready)
helm upgrade idwall-test . --install \
  --namespace idwall-test --create-namespace \
  -f values-prod.yaml --debug --wait

# Print the Service URL(s) (NodePort/tunnel depending on driver)
minikube service idwall-test -n idwall-test --url
