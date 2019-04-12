#!/bin/sh -e
### BEGIN INIT INFO
# HNXS StartUP
### END INIT INFO

PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/mnt/openbox/bin:/mnt/openbox/sbin"
# eth0 MAC
ifconfig eth0 down
ifconfig eth0 hw ether 00:0A:00:00:00:20
ifconfig eth0 up
#ifconfig eth0 add 1001::eeee:ffff:0016/64

#route
route add default gw 192.168.1.1

#nfs dir
#mount -t nfs 192.168.1.71:/usr/xilinx/arm-xilinx-linux-gnueabi/openbox /mnt/openbox/remote -o proto=tcp -o nolock &

#bridge
brctl addbr br0
#ifconfig br0 hw ether 3A:C4:74:31:8B:97
ifconfig br0 up

#PL obx
insmod /mnt/openbox/openbox-s4.ko xmac=0x00000020
ifconfig obx0 up
ifconfig obx1 up
ifconfig obx2 up
ifconfig obx3 up

exit 0

