variable "output_dir" {
    type        = string
    description = "Directory to write the output."
    default     = "builds"
}
variable "headless" {
    type        = bool
    description = "Run headless."
    default     = true
}
variable "iso_dir" {
    type        = string
    description = "Directory containing the OS .ISO file."
}
variable "iso_file" {
    type        = string
    description = "OS .ISO file."
}
variable "iso_checksum" {
    type        = string
    description = "OS .ISO file SHA256 hash."
}
variable "http_directory" {
    type        = string
    description = "OS kickstart or autoinstall directory."
    default     = "http"
}
variable "boot_wait" {
    type        = string
    description = "OS boot wait."
    default     = "10s"
}
variable "shutdown_command" {
    type        = string
    description = "OS shutdown command."
    default     = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
}
variable "os_name" {
    type        = string
    description = "OS Name."
}
variable "os_version" {
    type        = string
    description = "OS version."
}
variable "communicator" {
    type        = string
    description = "Medium to connect and communicate with VM, SSH."
    default     = "ssh"
}
variable "ssh_port" {
    type        = number
    description = "SSH port."
    default     = 22
}
variable "ssh_username" {
    type        = string
    description = "SSH user."
    default     = "vagrant"
}
variable "ssh_password" {
    type        = string
    description = "SSH password"
    default     = "vagrant"
}
variable "ssh_timeout" {
    type        = string
    description = "SSH timeout"
    default     = "10000s"
}
variable "guest_vm_hv_name" {
    type = string
    description = "Ok1."
}
variable "guest_vm_hv_os" {
    type = string
    description = "Ok1."
}
variable "guest_vm_hv_cpu" {
    type = number
    description = "O2k."
    default = 4
}
variable "guest_vm_hv_memory" {
    type = number
    description = "Ok aefwer erfwerwerer efer."
    default = 4096
}
variable "guest_vm_hv_disk" {
    type = number
    description = "O3."
    default = 51200
}
variable "vboxmanage" {
    type = list(list(string))
    description = "O3."
}
variable "vboxmanage_post" {
    type = list(list(string))
    description = "O3."
}
variable "guest_additions_iso" {
    type = string
    description = "VBoxGuestAdditions iso file"
}
variable "guest_additions_mode" {
    type = string
    description = "Upload mode."
}
variable "guest_additions_url" {
    type = string
    description = "VM Guest additions."
}
variable "guest_additions_sha256" {
    type = string
    description = "VM Guest additions."
}
variable "virtualbox_version_file" {
    type = string
    description = "VirtualBox version file."
}
variable "gfx_vram_size" {
    type = number
    description = "Video memory size in MB."
    default = 16
}
variable "vagrant_home_dir" {
    type = string
    description = "Vagrant user home directoy"
    default = "/home/vagrant"
}
variable "vagrant_private_key_url" {
    type = string
    description = "Vagrant private key URL."
    default = "https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant"
}
variable "vagrant_public_key_url" {
    type = string
    description = "Vagrant public key URL."
    default = "https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub"
}
