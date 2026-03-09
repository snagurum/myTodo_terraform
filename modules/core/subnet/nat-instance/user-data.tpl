#!/bin/bash

echo "------------------------------------ user-data execution -------------------------------------------"

sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

echo "----- net.ipv4.ip_forward =  -----"
cat /etc/sysctl.conf

IFACE=$(ip route | awk '/default/ {print $5}')
echo "----- IFACE=$IFACE -----"

iptables -t nat -A POSTROUTING -o $IFACE -j MASQUERADE
iptables -A FORWARD -s ${VPC_CIDR} -j ACCEPT
iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "----- sudo iptables -t nat -L -n -v ------"
sudo iptables -t nat -L -n -v

echo "----- sudo iptables -L -n -v -----"
sudo iptables -L -n -v

echo "----- cat /proc/sys/net/ipv4/ip_forward -----"
cat /proc/sys/net/ipv4/ip_forward

# #set -e

# # Install iptables service
# yum install -y iptables-services

# # Enable IP forwarding
# sysctl -w net.ipv4.ip_forward=1
# echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

# echo "printing file content.... /etc/sysctl.conf"
# cat /etc/sysctl.conf

# # Detect primary interface dynamically
# IFACE=$(ip route | awk '/default/ {print $5}')

# # Configure NAT
# iptables -t nat -A POSTROUTING -o $IFACE -j MASQUERADE

# # Enable and persist iptables
# systemctl enable iptables
# systemctl start iptables
# service iptables save


#-----------------------------------------

# yum install -y iptables-services

# # Enable IP forwarding
# sysctl -w net.ipv4.ip_forward=1
# # Make it persistent
# echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

# # Configure NAT rules
# iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# iptables-save > /etc/sysconfig/iptables

# systemctl enable iptables
# service iptables save
# systemctl start iptables
#-----------------------------------------