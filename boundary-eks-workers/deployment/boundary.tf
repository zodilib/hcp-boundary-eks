resource "kubernetes_deployment" "boundary" {
  metadata {
    name = "boundary"
    labels = {
      app = "boundary"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "boundary"
      }
    }

    template {
      metadata {
        labels = {
          app     = "boundary"
          service = "boundary"
        }
      }

      spec {
        volume {
          name = "boundary-config"

          config_map {
            name = "boundary-config"
          }
        }

        container {
          image = "hashicorp/boundary:0.10.2"
          name  = "boundary"
          security_context {
            privileged = true
	  }
          volume_mount {
            name       = "boundary-config"
            mount_path = "/boundary"
            read_only  = true
          }

          args = [
            "server",
            "-config",
            "/boundary/boundary.hcl"
          ]

          env {
            name  = "HOSTNAME"
            value = "boundary"
          }

          port {
            container_port = 9202
          }

        }
      }
    }
  }
}

resource "kubernetes_service" "boundary_controller" {
  metadata {
    name = "boundary-controller"
    labels = {
      app = "boundary-controller"
    }
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type": "nlb"
    }
  }

  spec {
    type = "LoadBalancer"
    selector = {
      app = "boundary"
    }

    port {
      name        = "data"
      port        = 9202
      target_port = 9202
    }
  }
}