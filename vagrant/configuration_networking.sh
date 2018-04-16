#!/usr/bin/env bash

# Usage info shown if wrong number of parameters is provided (all are required)
if (( $# != 8 )); then
    echo -e "Illegal number of parameters"
    echo -e "\nUsage:\n\t $0 -i IPv4 -n netmask -b broadcast -h hostname"
    echo -e "\nExample:\n\t $0 -i 192.168.0.100 -n 255.255.255.0 -b 192.168.0.255 -h linuxhost"
    exit 1
fi 

# Parsing provided parameters
while getopts ":i:n:b:h:" opt; do
  case $opt in
    i ) SET_IP=${OPTARG} >&2 ;;
    n ) SET_NETMASK=${OPTARG} >&2 ;;
    b ) SET_BROADCAST=${OPTARG} >&2 ;;
    h ) SET_HOSTNAME=${OPTARG} >&2 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 2 ;;
    : ) echo "Option -$OPTARG requires an argument." >&2; exit 3 ;;
  esac
done
shift $((OPTIND-1))

# Debug checkout
echo "==> Checking if parameters are correct"
echo "    ip:        $SET_IP"
echo "    netmask:   $SET_NETMASK"
echo "    broadcast: $SET_BROADCAST"
echo "    hostname:  $SET_HOSTNAME"

# Prepare 'interfaces' file
INTERFACES_CONTENT="auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
	address ${SET_IP}
	netmask ${SET_NETMASK}
        broadcast ${SET_BROADCAST}
	hostname ${SET_HOSTNAME}

auto eth1
iface eth1 inet dhcp"

# Change network configuration and restart eth0
echo "==> Changing network configuration"
echo "$INTERFACES_CONTENT" > interfaces

mv ./interfaces /etc/network/ -f
hostname $SET_HOSTNAME
ifdown eth0
ifup eth0
echo "    Done."

