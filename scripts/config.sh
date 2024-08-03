#!/bin/sh -eux

echo "-------------------------------------------------------------"
echo "--> Performing initial configuration"
echo "-------------------------------------------------------------"
# Configure SSH access for vagrant user
echo "Configuring vagrant user SSH access"
mkdir -p "$HOME_DIR"/.ssh;

if command -v wget >/dev/null 2>&1; then
    wget --quiet --no-check-certificate "$PRI_KEY" -O "$HOME_DIR"/.ssh/id_rsa;
    wget --quiet --no-check-certificate "$PUB_KEY" -O "$HOME_DIR"/.ssh/authorized_keys;
elif command -v curl >/dev/null 2>&1; then
    curl --silent --insecure --location "$PRI_KEY" > "$HOME_DIR"/.ssh/id_rsa;
    curl --silent --insecure --location "$PUB_KEY" > "$HOME_DIR"/.ssh/authorized_keys;
else
    echo "Cannot download vagrant private / public keys";
    exit 1;
fi

chown -R vagrant "$HOME_DIR"/.ssh;
chmod -R go-rwsx "$HOME_DIR"/.ssh;

/bin/echo 'UseDNS no' >> /etc/ssh/sshd_config

# Implement workaround to disable the LVM device 
# persistence otherwise results in a non bootable system.
# 'devices files sys_wwid last seen not founds'"
# 'timed out waiting for device /dev/mapper'"
# https://access.redhat.com/solutions/6889951
# https://access.redhat.com/solutions/7029161
# https://access.redhat.com/solutions/7014295
echo "Implementing workaround to disable LVM device persistence to avoid non-bootable system"
sed -i 's/# use_devicesfile = 1/use_devicesfile = 0/g' /etc/lvm/lvm.conf
sed -i 's/# use_devicesfile = 1/use_devicesfile = 0/g' /etc/lvm/lvm.conf

echo "Configuration completed"

# Upgrade system and reboot
echo "-------------------------------------------------------------"
echo "--> Performing upgrade"
echo "-------------------------------------------------------------"
dnf -y -q upgrade --skip-broken &>/dev/null

echo "System upgrade completed"

echo "-------------------------------------------------------------"
echo "--> Rebooting system"
echo "-------------------------------------------------------------"
reboot;
sleep 60;