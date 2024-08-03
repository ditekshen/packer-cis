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
variable "vm_name" {
    type = string
    description = "Name of the virtual machine."
}
#variable "vm_os" {
#    type = string
#    description = "Operating system of the virtual machine."
#}
variable "vm_cpu" {
    type = number
    description = "Number of CPUs to assign to the virtual machine."
    default = 4
}
variable "vm_memory" {
    type = number
    description = "Memory to assign to virtual machine."
    default = 4096
}
variable "vm_disk" {
    type = number
    description = "Disk size of virtual machine."
    default = 56000
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
variable "efi_firmware" {
    type = string
    description = "Path to OVMF_CODE.fd file containing EFI booting bootstrap."
    default = "/usr/share/edk2/ovmf/OVMF_CODE.fd"
}
variable "accelerator" {
    type = string
    description = "Accelerator to use when running the virtual machine."
    default = "kvm"
}
variable "format" {
    type = string
    description = "Output format of the virtual machine."
    default = "qcow2"
}
variable "machine_type" {
    type = string
    description = "Machine Type."
    default = "q35"
}
variable "net_device" {
    type = string
    description = "Network interface driver."
    default = "virtio-net"
}
variable "disk_interface" {
    type = string
    description = "Disk interface type"
    default = "virtio"
}
variable "vm_machine_type" {
    type = string
    description = "Type of machine for the virtual machine."
}
variable "qemu_binary" {
    type = string
    description = "Path to qemu binary."
    default = "/usr/libexec/qemu-kvm"
}
variable "qemuargs" {
    type = list(list(string))
    description = "Arguments to pass to qemu command line."
}
variable "disk_compression" {
    type = bool
    description = "Qcow2 disk compression."
}
variable "rh_username" {
    type = string
    description = "RedHat Subscription Manager username."
    sensitive = true
}
variable "rh_password" {
    type = string
    description = "RedHat Subscription Manager password."
    sensitive = true
}
