
resource "google_compute_instance" "default" {
  name         = var.app_name
  machine_type = var.tier
  zone         = var.region
  tags         = ["ssh"]

  metadata = {
    enable-oslogin = "TRUE"
  }
  boot_disk {
    initialize_params {
      image = var.os_type
    }
  }

  # Install Flask, SQLAlchemy
  metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python3-pip wget libmariadb-dev; pip3 install flask Flask-SQLAlchemy mysqlclient"

   
    network_interface {
    network = "default"
    access_config {}
  }
}

# add custom ssh firewall rule
resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = "default"
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

# # open port 5000
# resource "google_compute_firewall" "flask" {
#   name    = "flask-app-firewall"
#   network = "default"

#   allow {
#     protocol = "tcp"
#     ports    = ["5000"]
#   }
#   source_ranges = ["0.0.0.0/0"]
# }

# resource "google_sql_database_instance" "instance" {
#   name = var.db_instance
#   database_version = var.db_version
#   region = var.db_region

#   settings {
#     tier = var.db_tier
# }
# }


# resource "google_sql_database" "database" {
#   name = var.db_name
#   instance = "${google_sql_database_instance.instance.name}"
#   charset = "utf8"
#   collation = "utf8_general_ci"
# }


# resource "google_sql_user" "users" {
#   name = "root"
#   instance = "${google_sql_database_instance.instance.name}"
#   host = "%"
#   password = "mypassword"
# }