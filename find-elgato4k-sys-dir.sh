#!/usr/bin/env bash

for d in /sys/bus/usb/devices/* ; do
    if [ ! -r $d ]; then
        continue
    fi

    if [ ! -r $d/idVendor ]; then
        continue
    fi

    idVendor=$(<$d/idVendor)
    idProduct=$(<$d/idProduct)
    # manufacturer=$(<$d/manufacturer)
    # echo "$d $idVendor:$idProduct $manufacturer"
    if [ "$idVendor:$idProduct" = "0fd9:0066" ] ; then
        echo $d
        exit 0
    fi
done

exit 1