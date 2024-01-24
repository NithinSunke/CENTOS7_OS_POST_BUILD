#!/bin/bash

# Discover iSCSI targets
sudo iscsiadm --mode discovery --type sendtargets --portal mylab.scs.com

targets=$(iscsiadm --mode node | awk '{print $2}')


# Loop through the discovered targets and log in
for target in $targets; do
    echo "Logging in to iSCSI target: $target"
    iscsiadm --mode node --targetname $target --login
done

echo "iSCSI discovery and login completed."
