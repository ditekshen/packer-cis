#!/bin/sh -eux

VER="$(cat "$HOME_DIR"/.vbox_version)";
ISO="VBoxGuestAdditions_$VER.iso";

echo "-------------------------------------------------------------"
echo "--> VirtualBox guest additions installation"
echo "-------------------------------------------------------------"
deps=(bzip2 tar perl gcc dkms kernel-devel kernel-headers make)
dnf -y -q install epel-release &>/dev/null
dnf -y -q install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm &>/dev/null
dnf -y -q install "${deps[@]}" &>/dev/null
# To avoid "This system is currently not set up to build kernel modules."
# error, install kernel-devel-CURRENT_KERNEL
dnf -y -q install kernel-devel-$(uname -r) &>/dev/null

echo "Mounting and instaling VirtualBox guest additions"
# Create a mount point
mkdir /tmp/vboxga

# Load the loop module since it is not loaded by default
modprobe loop

# Mount VirtualBox Guest Additions ISO to the mount point
mount -t iso9660 -o loop "$HOME_DIR"/"$ISO" /tmp/vboxga

# Install VirtualBox Guest Additions for Linux
sh /tmp/vboxga/VBoxLinuxAdditions.run

# Unmount, remove loop module, and VirtualBox Guest Additions ISO
umount /tmp/vboxga
rmmod loop

# Delete residual files
rm -rf "$HOME_DIR"/*.iso
rm -rf "$HOME_DIR"/.vbox_version

echo "VirtualBox guest additions installation completed"