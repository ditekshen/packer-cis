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

echo "Configuration completed"

# Upgrade system and reboot
echo "-------------------------------------------------------------"
echo "--> Performing upgrade"
echo "-------------------------------------------------------------"
apt -y update &>/dev/null
apt -y full-upgrade &>/dev/null
apt -y dist-upgrade &>/dev/null

echo "System upgrade completed"

echo "-------------------------------------------------------------"
echo "--> Rebooting system"
echo "-------------------------------------------------------------"
reboot;
sleep 60;