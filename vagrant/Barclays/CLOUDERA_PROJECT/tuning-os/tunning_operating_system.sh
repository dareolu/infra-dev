#!/bin/bash

sudo yum -y install ntp
sudo chkconfig ntpd on
sudo /etc/init.d/ntpd start

sudo chkconfig iptables off
sudo /etc/init.d/iptables stop
sudo setenforce 0

sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sudo sh -c 'echo "* soft nofile 10000" >> /etc/security/limits.conf'
sudo sh -c 'echo "* hard nofile 10000" >> /etc/security/limits.conf'


################## Update O/S ports / TCP buffers / swappiness ####################

VM_SWAPPINESS=$(cat /proc/sys/vm/swappiness)

NET_IPV4_IP_LOCAL_PORT_RANGE=$(cat /proc/sys/net/ipv4/ip_local_port_range)

NET_CORE_RMEM=$(cat /proc/sys/net/core/rmem_max)
NET_CORE_wMEM=$(cat /proc/sys/net/core/wmem_max)

NET_IPV4_TCP_RMEM=$(cat /proc/sys/net/ipv4/tcp_rmem)
NET_IPV4_TCP_WMEM=$(cat /proc/sys/net/ipv4/tcp_wmem)

echo "O/S settings ..."
echo "VM_SWAPPINESS : $VM_SWAPPINESS"
echo "NET_IPV4_IP_LOCAL_PORT_RANGE : $NET_IPV4_IP_LOCAL_PORT_RANGE"

echo "NET_CORE_RMEM : $NET_CORE_RMEM"
echo "NET_CORE_wMEM : $NET_CORE_wMEM"

echo "NET_IPV4_TCP_RMEM : $NET_IPV4_TCP_RMEM"
echo "NET_IPV4_TCP_WMEM : $NET_IPV4_TCP_WMEM"



################## Update O/S ports / TCP buffers / swappiness ####################

cd /etc
\cp -rf sysctl.conf sysctl.conf.bak

echo '' >> /etc/sysctl.conf
echo '# Ephemeral ports' >> /etc/sysctl.conf
echo 'net.ipv4.ip_local_port_range = 41000 65000' >> /etc/sysctl.conf
echo '' >> /etc/sysctl.conf
echo '# TCP buffers' >> /etc/sysctl.conf
echo 'net.core.rmem_max = 16777216' >> /etc/sysctl.conf
echo 'net.core.wmem_max = 16777216' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_rmem = 4095 87380 16777216' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_wmem = 4095 65536 16777216' >> /etc/sysctl.conf
echo '' >> /etc/sysctl.conf
echo '# Decrease swappiness' >> /etc/sysctl.conf
echo 'vm.swappiness = 5' >> /etc/sysctl.conf
echo '' >> /etc/sysctl.conf

# These entries causes errors on running sysctl -p. comment out.
# Disable netfilter on bridges.
sed -i.bak s/net.bridge.bridge-nf-call/#net.bridge.bridge-nf-call-/g /etc/sysctl.conf

sysctl -p
