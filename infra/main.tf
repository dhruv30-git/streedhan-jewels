terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

variable "image" {
  type    = string
  default = "ghcr.io/dhruv30-git/streedhan-site:latest"
}

variable "host_port" {
  type    = number
  default = 8080
}

resource "docker_image" "site" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "site" {
  name      = "streedhan"
  image     = docker_image.site.image_id
  read_only = true
  tmpfs     = { "/tmp" = "" }

  capabilities {
    drop = ["ALL"]
  }

  security_opts = ["no-new-privileges"]

  ports {
    internal = 8080
    external = var.host_port
    ip       = "127.0.0.1"
  }
}

output "url" {
  value = "http://localhost:${var.host_port}"
}
