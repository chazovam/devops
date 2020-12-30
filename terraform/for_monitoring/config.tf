provider "google" {
    credentials = file("autonomous-key-297820-a48e4d065dfd.json")
    project = "autonomous-key-297820"
    region = "us-central1"
    zone = "us-central1-a"
}

resource "google_compute_instance" "vm_instance" {
    name = "test-vm"
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-1604-lts"
        }
    }

    network_interface {
        # A default network is created for all GCP projects
        #network = google_compute_network.vpc_network.self_link
        network = "default"
        access_config {
        }
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get -y update",
            "sudo service sshd restart"
        ]
  }
}