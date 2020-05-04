variable "gcp_project" {
  type = string
  default = "gke-playground-0423"
}

variable "gcp_credential_json" {
  type = string
  default = "/Users/david/workspace/credentials/gke-playground-0423-aacf6a39cc3f.json"

}

variable "gcp_region" {
  type = string
  default = "asia-east1"
}

variable "gcp_zone" {
  type = string
  default = "asia-east1-c"
}

variable "gcp_gke_name" {
  type = string
  default = "tekton-cd"
}

provider "google" {
  version = "3.5.0"

  credentials = file(var.gcp_credential_json)

  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

provider "google-beta" {
  version = "3.19.0"

  credentials = file(var.gcp_credential_json)

  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

resource "google_container_cluster" "primary" {
  provider = google-beta
  name     = var.gcp_gke_name
  location = var.gcp_zone

  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = "RAPID"
  }

  master_auth {
    username = "m5mPVLpmkWPGz9tK"
    password = "d3EvaeHEbY9ctEZa"

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name = "preemptible"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"
    # machine_type = "g1-small"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      usage = "tekton"
      owner = "devops"
    }
  }
}
