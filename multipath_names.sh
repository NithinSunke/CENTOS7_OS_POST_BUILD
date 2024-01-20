for dev in $(multipath -l | grep -Eo "sd[a-z]+"); do
    if [[ $dev == *"sdb"* ]]; then
        new_name="dockerfs"
    elif [[ $device == *"sdc"* ]]; then
        new_name="nas_storage"
    else
        new_name="unknown_storage"
    fi

    echo "Naming device $dev"
    multipathd -k"resize map $dev"
done