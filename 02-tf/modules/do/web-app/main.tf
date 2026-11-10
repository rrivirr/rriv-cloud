locals {
  # Only include VITE_DATA_API_URL when a value is supplied.
  vite_env = merge(
    {
      VITE_RRIV_API_BASE_URL  = var.rriv_api_base_url
      VITE_KEYCLOAK_URL       = var.keycloak_url
      VITE_KEYCLOAK_REALM     = var.keycloak_realm
      VITE_KEYCLOAK_CLIENT_ID = var.keycloak_client_id
    },
    var.data_api_url == null ? {} : { VITE_DATA_API_URL = var.data_api_url }
  )
}

resource "digitalocean_app" "rriv_web" {
  project_id = var.project_id

  spec {
    name   = var.app_name
    region = var.region

    dynamic "domain" {
      for_each = var.custom_domain == null ? [] : [var.custom_domain]
      content {
        name = domain.value
        type = "PRIMARY"
        zone = var.custom_domain_zone
      }
    }

    static_site {
      name             = "web"
      environment_slug = "node-js"

      # `npm run build` runs `tsc --noEmit` then `vite build` into dist/.
      build_command = "npm run build"
      output_dir    = "dist"

      index_document = "index.html"
      # SPA fallback: React Router handles /login, /callback, /silent-renew,
      # /library/:kind/:id, etc. client-side, so unknown paths serve index.html.
      catchall_document = "index.html"

      # Public repo, cloned without auth. Note: the `git` source does not
      # support deploy_on_push — redeploy via `terraform apply`, the control
      # panel, or `doctl apps create-deployment <app-id>`.
      git {
        repo_clone_url = var.repo_clone_url
        branch         = var.branch
      }

      dynamic "env" {
        for_each = local.vite_env
        content {
          key   = env.key
          value = env.value
          scope = "BUILD_TIME"
          type  = "GENERAL"
        }
      }
    }

    ingress {
      rule {
        component {
          name = "web"
        }
        match {
          path {
            prefix = "/"
          }
        }
      }
    }

    alert {
      rule = "DEPLOYMENT_FAILED"
    }
  }
}
