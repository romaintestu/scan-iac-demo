terraform {
required_version = ">= 1.4.0"
required_providers {
google = {
source = "hashicorp/google"
version = ">= 5.0"
}
}
}


provider "google" {
project = var.project_id
region = var.region
}


# ❌ Firewall permissive (0.0.0.0/0 on SSH)
resource "google_compute_firewall" "ssh_open" {
name = "allow-ssh-open"
network = var.vpc


allow {
protocol = "tcp"
ports = ["22"]
}
source_ranges = ["0.0.0.0/0"]
}


# ❌ GCS bucket publicly accessible via binding (for demo)
resource "google_storage_bucket" "public_bucket" {
name = "${var.project_id}-public-demo-bucket"
location = var.region
uniform_bucket_level_access = false
}


resource "google_storage_bucket_iam_member" "public_reader" {
bucket = google_storage_bucket.public_bucket.name
role = "roles/storage.objectViewer"
member = "allUsers"
}


# ❌ SQL instance without deletion protection (for demo)
resource "google_sql_database_instance" "db" {
name = "demo-sql"
database_version = "POSTGRES_14"
region = var.region


settings {
tier = "db-custom-1-3840"
}


deletion_protection = false
}
