#!/bin/sh

CFG=/config
echo Mounting configfs at $CFG
mkdir -p $CFG
mount none $CFG -t configfs
cd $CFG/usb_gadget

echo Create gadget hdmizness
mkdir -p hdmizness
cd hdmizness

echo Configure gadget
echo 0x1777 > idVendor
echo 0xcafe > idProduct
mkdir -p strings/0x409
grep Serial /proc/cpuinfo | awk '{ print $3 }' > strings/0x409/serialnumber
echo Tuetuopay > strings/0x409/manufacturer
echo HDMIzness > strings/0x409/product

if echo $@ | grep acm > /dev/null; then
    echo Configure ACM gadget
    mkdir -p configs/acm.1/strings/0x409
    mkdir -p functions/acm.usb0
    ln -s functions/acm.usb0 configs/acm.1
fi

if echo $@ | grep eth > /dev/null; then
    echo Configure ETH gadget
    mkdir -p configs/ncm.2/strings/0x409
    mkdir -p functions/ncm.usb0
    ln -s functions/ncm.usb0 configs/ncm.2
fi

if echo $@ | grep mass_storage > /dev/null; then
    echo Configure mass storage gadget
    mkdir -p configs/mass_storage.3/strings/0x409
    mkdir -p functions/mass_storage.usb0
    ln -s functions/mass_storage.usb0 configs/mass_storage.3
    echo /dev/random > functions/mass_storage.usb0/lun.0/file
    echo 1 > functions/mass_storage.usb0/lun.0/ro
fi

echo Enabling the gadget
if [ $(ls /sys/class/udc | wc -l) -eq 0 ]; then
    echo Error: no UDC device found
    exit 1
fi
udc=$(ls /sys/class/udc | head -n 1)
echo Using UDC device $udc
echo $udc > UDC
