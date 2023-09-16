provider "kubernetes" {
  config_path = "/home/ubuntu/.kube/config"
  config_context_cluster = "minikube"
}

provider "helm" {
  kubernetes {
    config_path = "/home/ubuntu/.kube/config"
  }
}


# Deploying Web app 
resource "kubernetes_deployment" "sample_metrics_app" {
  metadata {
    name = "sample-metrics-app-deployment"
    labels = {
      app = "sample-metrics-app"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "sample-metrics-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "sample-metrics-app"
        }
      }

      spec {
        container {
          image = "tkgregory/sample-metrics-application"
          name  = "sample-metrics-app"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "sample_metrics_app_service" {
  metadata {
    name = "sample-metrics-app-service"
  }

  spec {
    selector = {
      app = "sample-metrics-app"
    }

    port {
      port        = 8080
      target_port = 8080
      node_port   = 30080
    }

    type = "NodePort"
  }
}



# Deploying Prometheus and Grafana via Helm
resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  set {
    name  = "server.additionalScrapeConfigs"
    value = "additional-scrape-configs.yaml"
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  set {
    name  = "adminPassword"
    value = "Grafana@OVH#"
  }
}

