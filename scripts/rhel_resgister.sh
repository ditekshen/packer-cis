#!/bin/sh -eux

echo "-------------------------------------------------------------"
echo "--> Registering RedHat Subscription Manager"
echo "-------------------------------------------------------------"
subscription-manager register --username "$RH_USER" --password "$RH_PASS" --auto-attach &>/dev/null