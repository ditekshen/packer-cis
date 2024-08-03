#!/bin/sh -eux

echo "-------------------------------------------------------------"
echo "--> Unregistering RedHat Subscription Manager"
echo "-------------------------------------------------------------"
subscription-manager remove --all &>/dev/null
subscription-manager unregister &>/dev/null
subscription-manager clean &>/dev/null
rm -rf /var/log/rhsm/*