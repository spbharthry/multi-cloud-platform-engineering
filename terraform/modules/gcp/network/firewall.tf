# Explicit deny-ingress baseline for the VPC
resource "google_compute_firewall" "deny_ingress" {
  project   = var.project_id
  name      = "${var.name}-deny-ingress"
  network   = google_compute_network.this.name
  direction = "INGRESS"
  priority  = 65534

  source_ranges = ["0.0.0.0/0"]

  deny {
    protocol = "all"
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}