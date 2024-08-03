output_dir                  = "builds"
headless                    = true
iso_dir                     = "iso"
iso_file                    = "ubuntu-22.04.4-live-server-amd64.iso"
iso_checksum                = "faa97fdcff0ca48a28fdb447308819f8f732be7b13a2f53b7cbd5590cec89a0a"
os_name                     = "Ubuntu"
os_version                  = "22.04LTS"
http_directory              = "http"
boot_wait                   = "10s"
shutdown_command            = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
communicator                = "ssh"
ssh_port                    = 22
ssh_username                = "vagrant"
ssh_password                = "vagrant"
ssh_timeout                 = "10000s"
guest_vm_hv_name            = "ubuntu22-cis"
guest_vm_hv_os              = "Ubuntu22_LTS_64"
guest_vm_hv_cpu             = 4
guest_vm_hv_memory          = 4096
guest_vm_hv_disk            = 65000
gfx_vram_size               = 16
guest_additions_iso         = "VBoxGuestAdditions_{{ .Version }}.iso"
guest_additions_mode        = "upload"
guest_additions_url         = "iso/VBoxGuestAdditions_{{ .Version }}.iso"
#guest_additions_sha256      = "4469bab0f59c62312b0a1b67dcf9c07a8a971afad339fa2c3eb80e209e099ef9" # 7.0.18
guest_additions_sha256      = "4c7523fa6d17436e3b7788f62956674270572cfefa340d03111b85f8517d5981" # 7.0.20
virtualbox_version_file     = ".vbox_version"
vboxmanage      = [
        ["modifyvm", "{{ .Name }}", "--cpus", "4"],
        ["modifyvm", "{{ .Name }}", "--memory", "4096"],
        ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
        ["modifyvm", "{{ .Name }}", "--audio-driver", "none", "--nat-localhostreachable1", "on"]
    ]
vboxmanage_post = [
        ["modifyvm", "{{ .Name }}", "--cpus", "4"],
        ["modifyvm", "{{ .Name }}", "--memory", "4096"],
        ["modifyvm", "{{ .Name }}", "--firmware", "EFI"],
        ["modifyvm", "{{ .Name }}", "--audio-driver", "none", "--nat-localhostreachable1", "on"]
    ]
