# sre-web-app

## Objective

- Run a provided sre-hiring application.
- Implement a deployment system with Kubernetes (minikub, k3d ... ) and Helm.
- You can improve, propose and implement everything you want.
- Monitor the application.

## Prerequisites
- Linux workstation (I am using Ubuntu 20.04) with at least 15 Gb ram.
  `````
  cat /etc/*release*
  `````
- Install the following packages [curl, Docker, Minikube, kubectl, Helm, Terraform]:
  `````
  sudo mkdir /opt/sre-web-app
  sudo cd /opt/sre-web-app
  git clone https://github.com/Ourkish/sre-web-app.git
  sudo chmod +x dep_install.sh
  sudo ./auto_install.sh
  `````
- get the web app
  in this lab we used a Java Web app (https://hub.docker.com/r/tkgregory/sample-metrics-application)
  
## Understanding the Operation

- Minikube provides a local Kubernetes environment where you can deploy and manage containerized applications using Kubernetes resources.
- Docker containers can be built and pushed to container registries. Kubernetes can then pull these containers and deploy them as pods (the smallest deployable units in Kubernetes).
- kubectl is used to interact with the Minikube Kubernetes cluster. You can create pods, services, deployments, and other Kubernetes resources using kubectl commands.
- Helm simplifies the installation of complex applications in Kubernetes. Helm charts describe how to deploy applications, including the necessary Kubernetes resources. You can use Helm to install and manage applications 
  in your Minikube cluster.
- Terraform can manage Kubernetes resources in Minikube as well as other infrastructure resources outside of Kubernetes. It uses Terraform providers to interact with the Kubernetes API and provision resources like 
  namespaces, secrets, and ConfigMaps.

## In Practice
- Quick Start :
  Clone the project on your environement and run those commands (if not already done !) :
  `````
  git clone https://github.com/Ourkish/sre-web-app.git
  sudo chmod +x dep_install.sh
  sudo ./auto_install.sh
  sudo terraform apply
  `````
  
