#!/bin/bash

# Install curl
sudo apt-get update
sudo apt install -y curl


# Install Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

# Install kubectl
sudo apt-get install -y kubectl

# Start Minikube
minikube start --driver=docker

# Install Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install -y apt-transport-https
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install -y helm

# Install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install -y terraform

# Add Helm repositories
helm repo add stable https://charts.helm.sh/stable
helm repo update

# Verify installations
minikube version
kubectl version --client
helm version --short
terraform version

# Set up kubectl to use Minikube's context
kubectl config use-context minikube

echo "Installation completed!"

