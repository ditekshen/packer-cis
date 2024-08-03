#!/bin/sh -eux

echo "-------------------------------------------------------------"
echo "--> Performing clean up"
echo "-------------------------------------------------------------"
# Remove uneeded packages
dnf -y -q autoremove &>/dev/null
# We only need 1 kernel (latest) on dev = size reduction
dnf -y -q remove "$(dnf repoquery --installonly --latest-limit=-1 -q)" &>/dev/null
# Remove linux kernel development and firmware pakcages"
packages=(kernel-devel linux-firmware epel-release)
dnf -y -q remove "${packages[@]}" &>/dev/null

# Clean temporary and cache directories
dnf -y clean all
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/cache/*
rm -rf /usr/share/doc/*

# Reset machine-id
truncate -s 0 /etc/machine-id

# Clear history and logs
cat /dev/null > /var/log/audit/audit.log
cat /dev/null > /var/log/wtmp
cat /dev/null > /var/log/lastlog
history -cw
echo > ~/.bash_history
rm -rf /root/.bash_history

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M || true
rm -f /EMPTY

# Sync to ensure that the delete completes before this moves on.
sync
sync

echo "Clean up completed"