#!/bin/bash

# Specify the multipath disk names you want to add
MULTIPATH_DISKS=("dockerfs")

# Specify the path to the multipath configuration file
MULTIPATH_CONFIG_FILE="/etc/multipath.conf"

# Check if the configuration file exists, create it if not
if [ ! -e "$MULTIPATH_CONFIG_FILE" ]; then
    touch "$MULTIPATH_CONFIG_FILE"
fi

# Loop through each multipath disk name and add it to the configuration file
for DISK_NAME in "${MULTIPATH_DISKS[@]}"; do
    # Check if the disk name already exists in the configuration file
    if ! grep -q "$DISK_NAME" "$MULTIPATH_CONFIG_FILE"; then
        # Append the disk name to the configuration file
        echo "multipath {" >> "$MULTIPATH_CONFIG_FILE"
        echo "    wwid $DISK_NAME" >> "$MULTIPATH_CONFIG_FILE"
        echo "}" >> "$MULTIPATH_CONFIG_FILE"
        echo >> "$MULTIPATH_CONFIG_FILE"  # Add a blank line for separation
        echo "Added $DISK_NAME to $MULTIPATH_CONFIG_FILE"
    else
        echo "$DISK_NAME already exists in $MULTIPATH_CONFIG_FILE"
    fi
done
