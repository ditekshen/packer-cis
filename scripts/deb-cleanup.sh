#!/bin/sh -eux

echo "-------------------------------------------------------------"
echo "--> Performing clean up"
echo "-------------------------------------------------------------"
# Remove uneeded packages
apt -y -q autoremove &>/dev/null
# Remove linux kernel development and firmware pakcages"
packages=(kernel-dev linux-firmware)
apt -y -q remove "${packages[@]}" &>/dev/null

# Clean temporary and cache directories
apt clean all &>/dev/null
apt distclean &>/dev/null
apt autoclean &>/dev/null

rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/cache/*
rm -rf /usr/share/doc/*

# Reset machine-id
truncate -s 0 /etc/machine-id

# Clear history and logs
cat /dev/null > /var/log/wtmp
cat /dev/null > /var/log/lastlog
rm -rf /var/log/install/*
history -cw
echo > ~/.bash_history
rm -rf /root/.bash_history
rm -rf /home/vagrant/.wget-hsts

# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M || true
rm -f /EMPTY

# Sync to ensure that the delete completes before this moves on.
sync
sync

echo "Clean up completed"