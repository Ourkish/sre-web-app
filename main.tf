provider "kubernetes" {
  config_path = "/home/ubuntu/.kube/config"
  config_context_cluster = "minikube"
}

provider "helm" {
  kubernetes {
    config_path = "/home/ubuntu/.kube/config"
  }
}


resource "kubernetes_persistent_volume_claim" "grafana_data" {
  metadata {
    name = "grafana-data"  # This name should match the one in your Helm release
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"  # Adjust the size as needed
      }
    }
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



resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  
  set {
    name  = "server.additionalScrapeConfigs"
    value = <<EOF
- job_name: 'sample-metrics-app'
  static_configs:
  - targets: ['sample-metrics-app-service:8080']
    labels:
      app: sample-metrics-app
  metrics_path: /actuator/prometheus
  scheme: http
EOF
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
  set {
    name  = "persistence.enabled"
    value = "true"
  }
  set {
    name  = "persistence.existingClaim"
    value = "grafana-data"  # Use the name of your existing PVC or specify a new one
  }
}

