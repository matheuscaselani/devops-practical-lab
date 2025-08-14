# Desafio 02: Kubernetes

## Requirements

  * Packages: 
    * docker
    * docker-buildx
    * colima
    * minikube
    * helm
    * kubectl
  * values.yaml
    * Containing all needs for the project
  * Chart.yaml
    * Standard chart template containing usefull data for many deployment kinds.

## Helm Template Pattern

  * "Default" helm chart using the following components:
    * _helpers_tpl
    * deployment
    * hpa
    * ingress
    * service
  * Start Up Script
    * Start Colima with Docker runtime and minimal resources.
    * Ensure Docker CLI is using Colima's context.
    * Start Minikube using the Docker (Colima) driver.
    * Build the local container image and load it into the local Docker daemon.
    * Load the image into Minikube's container runtime.
    * Deploy the Helm chart (wait for resources to become ready).
    * Print the Service URL(s) (NodePort/tunnel depending on driver).

## Deployment Steps

  * To fully deploy this project, just run the following:
    ```Bash
    chmod +x ./startup.sh && bash ./startup.sh
    ```

