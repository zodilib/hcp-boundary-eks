resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx"
    labels = {
      app = "nginx"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          service = "nginx"
          app     = "nginx"
        }
      }

      spec {
        volume {
          name = "nginx-config"

          config_map {
            name = "nginx-config"
          }
        }


        container {
          image = "httpd"
          name  = "nginx"

          volume_mount {
            name = "nginx-config"
            mount_path = "/usr/local/apache2/htdocs/"
            read_only = true
          }

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "nginx"
    labels = {
      app = "nginx"
    }
  }

  spec {
    type = "ClusterIP"
    selector = {
      app = "nginx"
    }

    port {
      port        = 80
      target_port = 80
    }
  }
}