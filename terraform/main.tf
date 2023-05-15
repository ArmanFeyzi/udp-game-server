provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_deployment" "game_server" {
  metadata {
    name = "game-server"
  }

  spec {
    selector {
      match_labels = {
        app = "game-server"
      }
    }

    replicas = 1

    template {
      metadata {
        labels = {
          app = "game-server"
        }
      }

      spec {
        container {
          image = "armanfeyzi/fake-game-server"
          name = "game-server"
          port {
            container_port = 7778
            protocol = "UDP"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "game_server" {
  metadata {
    name = "game-server"
  }

  spec {
    selector = {
      app = "game-server"
    }

    port {
      name = "game-server"
      port = 7778
      protocol = "UDP"
      target_port = 7778
    }

    type = "NodePort"
  }
}
