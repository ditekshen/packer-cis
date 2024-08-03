## Packer CIS

Setup CIS Benchamrks partitioned Vagrant boxes for various operating systems under VirtualBox and Qemu virtualization platforms.

Review [Center for Internet Security CIS Benchmarks Download](https://downloads.cisecurity.org/#/) for overview on the paritioning scheme and options for the respective operating system.

## Purpose

Test application deployment and the necessary configuration changes on top of CIS benchmarked operating systems.

## Prerequisites

Enable ```CRB``` or ```CodeReady``` and EPEL repositories.

### Install Packer and Vagrant

```bash
$ dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
$ dnf install packer vagrant
```

### Install VirtualBox

```bash
$ dnf install binutils kernel-devel kernel-headers libgomp make patch gcc glibc-headers glibc-devel dkms
$ dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo
$ dnf install VirtualBox-7.0
$ usermod -aG vboxusers $USER

# Download and install Extension Pack
$ wget https://download.virtualbox.org/virtualbox/7.0.20/Oracle_VM_VirtualBox_Extension_Pack-7.0.20.vbox-extpack
$ VBoxManage extpack install --replace Oracle_VM_VirtualBox_Extension_Pack-7.0.20.vbox-extpack
```

### Install Qemu KVM

```bash
$ dnf install qemu-kvm libvirt virt-install virt-viewer
$ usermod -aG libvirt $USER
$ usermod -aG qemu $USER
```

__Note__: VirtualBox and Qemu can coexist, but not run simultaneously.

## Usage

Clone this repository, place ```.ISO``` files into the ```iso``` directory, including Virtbox Guest Additions, and then build a box of choice.

```bash
$ git clone https://github.com/ditekshen/packer-cis.git
$ cd packer-cis

# Example for VirtualBox
$ packer build vbox/rocky9/

# Example for Qemu
$ packer build qemu/rocky9/
```

## Supported Operating Systems

| OS                   | ISO                                  |
|----------------------|--------------------------------------|
| AlmaLinux 8 Minimal  | AlmaLinux-8.10-x86_64-minimal.iso    |
| AlmaLinux 9 Minimal  | AlmaLinux-9.4-x86_64-minimal.iso     |
| OracleLinux 8        | OracleLinux-R8-U10-x86_64-dvd.iso    |
| OracleLinux 9        | OracleLinux-R9-U4-x86_64-dvd.iso     |
| Redhat 8             | rhel-8.10-x86_64-dvd.iso             |
| Redhat 9             | rhel-9.4-x86_64-dvd.iso              |
| RockyLinux 8 Minimal | Rocky-8.10-x86_64-minimal.iso        |
| RockyLinux 9 Minimal | Rocky-9.4-x86_64-minimal.iso         |
| Ubuntu 22.04         | ubuntu-22.04.4-live-server-amd64.iso |
| Ubuntu 24.04         | ubuntu-24.04-live-server-amd64.iso   |

## References

- [Center for Internet Security CIS Benchmarks Download](https://downloads.cisecurity.org/#/)
