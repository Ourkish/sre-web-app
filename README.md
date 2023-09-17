# sre-web-app

## Objective

- Run a provided sre-web-app application
- Implement a deployment system with Kubernetes (minikub, k3d ... ) and Helm.
- You can improve, propose and implement everything you want.
- Monitor the application.

## Prerequisites

- Linux workstation (I am using Ubuntu 20.04) with at least 15 Gb ram (r2-15 flavor on OVH) .
  `````
  cat /etc/*release*
  `````
- Install the following packages [curl, Docker, Minikube, kubectl, Helm, Terraform]:
  `````
  sudo mkdir /opt/sre-web-app
  sudo cd /opt/sre-web-app
  git clone https://github.com/Ourkish/sre-web-app.git
  sudo chmod +x auto_install.sh
  sudo ./auto_install.sh
  `````
- get the web app
  in this lab we used a Java Web app (https://hub.docker.com/r/tkgregory/sample-metrics-application)
  
## Understanding the operation

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
- Below are screenshots showcasing the results following the deployment and execution of the code.
  
  Application Monitoring :
  
  ![jvm_dashboard](https://github.com/Ourkish/sre-web-app/assets/67292535/c888760b-1166-471e-925f-882cb5fda8b5)

  Deployment using terraform :
  
  ![pods](https://github.com/Ourkish/sre-web-app/assets/67292535/fe3d8bcc-05ce-4c50-ad74-7d34f094002d)

  App metrics after deployment :
  
  ![web_app_metrics](https://github.com/Ourkish/sre-web-app/assets/67292535/b89fd98e-b968-4d83-bb5d-7dee749bc0f7)

  Kubernetes Dashboard :
  
  ![kube_dashboard](https://github.com/Ourkish/sre-web-app/assets/67292535/8762a72c-2ac2-47e4-a965-baf36bc6692a)

  To destroy the cluster use this command :
  `````
  sudo terraform destroy
  `````
  you will be asked to confirme, if you agree to destroy you should see an output like this :
  
  ![destroy_cluster](https://github.com/Ourkish/sre-web-app/assets/67292535/e70e4a92-c5eb-49a9-8593-08663cb072f5)


  
  
