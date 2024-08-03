output_dir                  = "builds"
headless                    = true
iso_dir                     = "iso"
iso_file                    = "AlmaLinux-9.4-x86_64-minimal.iso"
iso_checksum                = "sha256:20123bb9f8319143e792b906137236bdcb0d10b023c36626ca2d8e9f62144eb9"
os_name                     = "AlmaLinux"
os_version                  = "9.4"
http_directory              = "http"
boot_wait                   = "10s"
shutdown_command            = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
communicator                = "ssh"
ssh_port                    = 22
ssh_username                = "vagrant"
ssh_password                = "vagrant"
ssh_timeout                 = "10000s"
accelerator                 = "kvm"
vm_name                     = "alma9-cis"
vm_machine_type             = "q35"
vm_cpu                      = 4
vm_memory                   = 4096
vm_disk                     = 56000
format                      = "qcow2"
efi_firmware                = "/usr/share/edk2/ovmf/OVMF_CODE.fd"
net_device                  = "virtio-net"
disk_interface              = "virtio"
disk_compression            = true
qemuargs                    = [["-cpu", "host"], ["-smp", "4"], ["-m", "4096"]]

