output_dir                  = "builds"
headless                    = true
iso_dir                     = "iso"
iso_file                    = "rhel-9.4-x86_64-dvd.iso"
iso_checksum                = "sha256:398561d7b66f1a4bf23664f4aa8f2cfbb3641aa2f01a320068e86bd1fc0e9076"
os_name                     = "RHEL"
os_version                  = "9.4"
http_directory              = "http"
boot_wait                   = "10s"
shutdown_command            = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
communicator                = "ssh"
ssh_port                    = 22
ssh_username                = "vagrant"
ssh_password                = "vagrant"
ssh_timeout                 = "10000s"
guest_vm_hv_name            = "rhel9-cis"
guest_vm_hv_os              = "RedHat9_64"
guest_vm_hv_cpu             = 4
guest_vm_hv_memory          = 4096
guest_vm_hv_disk            = 56000
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
