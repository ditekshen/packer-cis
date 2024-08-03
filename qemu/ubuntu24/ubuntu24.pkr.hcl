packer {
    required_version = ">= 1.11.0"
    required_plugins {
        vagrant = {
            source  = "github.com/hashicorp/vagrant"
            version = ">= 1.1.4"
        }
        virtualbox = {
            source  = "github.com/hashicorp/qemu"
            version = ">= 1.0.5"
        }
    }
}

locals {
    build_timestamp          = formatdate("YYYY-MM-DD'T'hh-mm-ssZ", timestamp())
    build_version            = formatdate("YYYY.MM", timestamp())
    build_name               = "CIS-${ var.os_name }-${ var.os_version }-${ local.build_version }-${ local.build_timestamp }.{{ .Provider }}.box"
    boot_command = [
        "<wait>c<wait>",
        "linux /casper/vmlinuz<wait> autoinstall<wait>",
        " ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/qemu-ubuntu/' ---",
        "<wait><enter><wait>initrd /casper/initrd",
        "<wait><enter><wait>boot<enter>"
    ]
    guest_vm_hv_description  = "PROFILE: CIS Benchmark Partition\nOS: ${ var.os_name }-${ var.os_version }\nVER: ${ local.build_version }\nBUILD: ${ local.build_timestamp }\nISO: ${var.iso_file}"
}

source "qemu" "ubuntu24" {
    use_pflash              = false
    efi_boot                = true
    efi_firmware_code       = var.efi_firmware
    boot_wait               = var.boot_wait
    boot_command            = local.boot_command
    shutdown_command        = var.shutdown_command
    accelerator             = var.accelerator
    communicator            = var.communicator
    headless                = var.headless
    http_directory          = var.http_directory
    iso_urls                = ["${var.iso_dir}/${var.iso_file}"]
    iso_checksum            = var.iso_checksum
    ssh_port                = var.ssh_port
    ssh_timeout             = var.ssh_timeout
    ssh_username            = var.ssh_username
    ssh_password            = var.ssh_password
    vm_name                 = var.vm_name
    machine_type            = var.vm_machine_type
    cpus                    = var.vm_cpu
    memory                  = var.vm_memory
    disk_size               = var.vm_disk
    disk_compression        = var.disk_compression
    format                  = var.format
    net_device              = var.net_device
    disk_interface          = var.disk_interface
    qemu_binary             = var.qemu_binary
    qemuargs                = var.qemuargs
}

build {
    sources = ["source.qemu.ubuntu24"]

    provisioner "shell" {
        expect_disconnect =  true
        execute_command   = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
        environment_vars  = [
            "HOME_DIR=${ var.vagrant_home_dir }",
            "PRI_KEY=${ var.vagrant_private_key_url}",
            "PUB_KEY=${ var.vagrant_public_key_url}"
        ]
        scripts           = ["${path.root}/../../scripts/deb-config.sh"]
        
    }

    provisioner "shell" {
        pause_before        = "5m"
        start_retry_timeout = "30m"
        execute_command     = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
        environment_vars    = ["HOME_DIR=${ var.vagrant_home_dir }"]
        scripts             = ["${path.root}/../../scripts/deb-cleanup.sh"]
    }

    post-processor "vagrant" {
        provider_override = "libvirt"
        compression_level = 9
        output            = "${path.root}/../../${var.output_dir}/${ local.build_name }"
    }
}
