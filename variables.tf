variable "name" {
  type = string
  description = "Machine Name"
}
variable "machine_type" {
  type = string
  description = "Add machine type"
}
variable "disksize" {
  type = number
  description = "Total boot disk size needs to be assigned"
}
variable "kms_key" {
  type = string
  description = "KMS Key for Compute instance"
}
variable "zone" {
  type = string
  description = "zone for compute instance"
}
variable "auto_delete_disk" {
  type = bool
  default = true
  description = "Auto delte for boot disk"
}
variable "disktype" {
  type = string
  default = "pd-standard"
  description = "use pd-ssd or pd-standard for boot disk type"
}
variable "subnet" {
  type = string
  description = "Subnet which needs to be use for compute instance"
}
variable "static_ip" {
  type = string
  description = "Static IP if you have resererved any for your compute instance"
  default = ""
}
variable "labels" {
  type = map(string)
  description = "For more than one lable you can have number of labels."
  default = null
}
variable "network_tag" {
  type = list(string)
  description = "We can have network tag if you would like to use any"
  default = null
}
variable "startup_script" {
  type = string
  description = "Start up script"
  default = null
}
variable "project_id" {
  type = string
  description = "Project ID"
}
variable "image_family" {
  type = string
  description = "Image family"
}
variable "service_account" {
  type = object({
    email = string
    scopes = list(string)
  })
  default = null
}
variable "allow_stopping_forupdate" {
  type = bool
  default = true
  description = "Stop the instance for any update"
}
variable "oslogin_enable" {
  default = true
  type = bool
  description = "Os login for instance"
}
