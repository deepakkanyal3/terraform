module "nexus_proxy_repo" {
  source = "../../../../../../modules/nexus-repo"
  s3_bucket = var.s3_bucket
  group_blob_store_name = var.group_blob_store_name
  group-http-port = var.group-http-port
  dockerhosted_http_port = var.dockerhosted_http_port
  create_hosted_repo  = var.create_hosted_repo
  create_helmhosted_repo  = var.create_helmhosted_repo
  
  proxy-repositories = {
    ghcr-io = {
      name             = "ghcr-io"
      http_port        = 8086
      remote_url       = "https://ghcr.io"
    }
    k8s-io = {
      name             = "k8s-io"
      http_port        = 8087
      remote_url       = "https://registry-sandbox.k8s.io"
    }
    quay-io = {
      name             = "quay-io"
      http_port        = 8088
      remote_url       = "https://quay.io/"
    }
  }
  helm-proxy-repositories = {
    prometheus-community = {
      name             = "prometheus-community"
      remote_url       = "https://prometheus-community.github.io/helm-charts/"
    },

    fluent-github      = {
      name             = "fluent-github"
      remote_url       = "https://fluent.github.io/helm-charts"
    }
    grafana-github     = {
      name             = "grafana-github"
      remote_url       = "https://grafana.github.io/helm-charts"
    }
    helm-mattermost    = {
      name             = "helm-mattermost"
      remote_url       = "https://helm.mattermost.com"
    }
    julb-chart         = {
      name             = "julb-chart"
      remote_url       = "https://grafana.github.io/helm-charts"
    }
    kedacore-github    = {
      name             = "kedacore-github"
      remote_url       = "https://grafana.github.io/helm-charts"
    }
    kubernetes-sigs    = {
      name             = "kubernetes-sigs"
      remote_url       = "https://kubernetes-sigs.github.io/descheduler/"
    }
    mysql-github       = {
      name             = "mysql-github"
      remote_url       = "https://mysql.github.io/mysql-operator/"
    }
    mysql-github       = {
      name             = "mysql-github"
      remote_url       = "https://mysql.github.io/mysql-operator/"
    }
    nexus-gromo        = {
      name             = "nexus-gromo"
      remote_url       = "https://nexus.gromo.in/repository/gromo-helm/"
    }
    open-telemetry     = {
      name             = "open-telemetry"
      remote_url       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
    }
    sonar-source       = {
      name             = "sonar-source"
      remote_url       = "https://SonarSource.github.io/helm-chart-sonarqube"
    }

  }
  providers = {
    nexus = nexus
  }
}
output docker_proxy {
  value       = module.nexus_proxy_repo.docker_proxy
}
