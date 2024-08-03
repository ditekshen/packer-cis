packer {
    required_version = ">= 1.11.0"
    required_plugins {
        vagrant = {
            source  = "github.com/hashicorp/vagrant"
            version = ">= 1.1.4"
        }
        virtualbox = {
            source  = "github.com/hashicorp/virtualbox"
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
        " ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/' ---",
        "<wait><enter><wait>initrd /casper/initrd",
        "<wait><enter><wait>boot<enter>"
    ]
#    boot_command = [
#        "<wait>c<wait>",
#        "linux /casper/vmlinuz<wait> autoinstall<wait>",
#        " ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
#        "<wait><enter><wait>initrd /casper/initrd",
#        "<wait><enter><wait>boot<enter>"
#    ]
    guest_vm_hv_description  = "PROFILE: CIS Benchmark Partition\nOS: ${ var.os_name }-${ var.os_version }\nVER: ${ local.build_version }\nBUILD: ${ local.build_timestamp }\nISO: ${var.iso_file}"
    export_opts              = [
        "--manifest",
        "--vsys", "0",
        "--description", "${local.guest_vm_hv_description}",
        "--version", "${local.build_version}"
    ]
}

source "virtualbox-iso" "ubuntu24" {
    boot_command            = local.boot_command
    boot_wait               = var.boot_wait
    communicator            = var.communicator
    headless                = var.headless
    http_directory          = var.http_directory
    iso_urls                = ["${var.iso_dir}/${var.iso_file}"]
    iso_checksum            = var.iso_checksum
    ssh_port                = var.ssh_port
    ssh_timeout             = var.ssh_timeout
    ssh_username            = var.ssh_username
    ssh_password            = var.ssh_password
    vm_name                 = var.guest_vm_hv_name
    guest_os_type           = var.guest_vm_hv_os
    cpus                    = var.guest_vm_hv_cpu
    memory                  = var.guest_vm_hv_memory
    disk_size               = var.guest_vm_hv_disk
    gfx_vram_size           = var.gfx_vram_size
    guest_additions_path    = var.guest_additions_iso
    guest_additions_mode    = var.guest_additions_mode
    guest_additions_url     = var.guest_additions_url
    guest_additions_sha256  = var.guest_additions_sha256
    virtualbox_version_file = var.virtualbox_version_file
    shutdown_command        = var.shutdown_command
    vboxmanage              = var.vboxmanage
    vboxmanage_post         = var.vboxmanage_post
    export_opts             = local.export_opts
}

build {
    sources = ["source.virtualbox-iso.ubuntu24"]

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
        scripts             = [
            "${path.root}/../../scripts/deb-vboxga.sh",
            "${path.root}/../../scripts/deb-cleanup.sh"
        ]
    }

    post-processor "vagrant" {
        compression_level = 9
        output            = "${path.root}/../../${var.output_dir}/${ local.build_name }"
    }
}
