output_dir                  = "builds"
headless                    = true
iso_dir                     = "iso"
iso_file                    = "Rocky-8.10-x86_64-minimal.iso"
iso_checksum                = "2c735d3b0de921bd671a0e2d08461e3593ac84f64cdaef32e3ed56ba01f74f4b"
os_name                     = "RockyLinux"
os_version                  = "8.10"
http_directory              = "http"
boot_wait                   = "10s"
shutdown_command            = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
communicator                = "ssh"
ssh_port                    = 22
ssh_username                = "vagrant"
ssh_password                = "vagrant"
ssh_timeout                 = "10000s"
accelerator                 = "kvm"
vm_name                     = "rocky8-cis"
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
