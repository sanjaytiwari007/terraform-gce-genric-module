locals {
  gce_labels = merge(var.labels,{
    createdby = "Sanjay Tiwari"
    tfversion = "v0.0.0"
  })
}
data "google_compute_image" "default" {
  family = var.image_family
  project = var.project_id
}
resource "google_compute_instance" "default" {
  project = var.project_id
  machine_type = var.machine_type
  name = var.name
  zone = var.zone
  allow_stopping_for_update = var.allow_stopping_forupdate
  boot_disk {
    #KMS key for CMEK encryption
    kms_key_self_link = var.kms_key
    auto_delete = var.auto_delete_disk
    initialize_params {
      image = data.google_compute_image.default.self_link
      size = var.disksize
      type = var.disktype
    }
  }
  labels = local.gce_labels
  network_interface {
    subnetwork = var.subnet
    #Only use this when you have static internal IP
    network_ip = var.static_ip
  }
  #Use this for Network tag if you have for your firewall rule
  tags = var.network_tag == null? [] : var.network_tag
  #Use this to pass your startup script
  metadata_startup_script = (var.startup_script == null ) ? null : file(var.startup_script)
  metadata {
    enable-oslogin = var.oslogin_enable
  }
  #We will use a servcie account which will control server access
  dynamic "service_account" {
    for_each = var.service_account == null ? [] : [var.service_account]
    content {
      email = lookup(service_account.value, "email",null)
      scopes = lookup(service_account.value,"scopes", null )
    }
  }
  #This is required in order to stop rebuild if new image will be there.
  lifecycle {
    ignore_changes = [
    boot_disk[0].initialize_params[0].image
    ]
  }
}