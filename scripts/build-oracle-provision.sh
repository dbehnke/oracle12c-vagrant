#!/bin/bash
#sudo yum -y groupinstall "Compatibility libraries" "Hardware monitoring utilities" "Large Systems Performance" "Network file system client" "Performance Tools" "Perl Support" "Server Platform" "System administration tools" "Desktop" "Desktop Platform" "Fonts" "General Purpose Desktop" "Graphical Administration Tools" "Input Methods" "X Window System" "Internet Browser" "Additional Development" "Development Tools"
sudo yum -y install oracle-rdbms-server-12cR1-preinstall

#modify hosts
sudo cp /vagrant/env/etc/hosts /etc/hosts
sudo cp /vagrant/env/etc/sysconfig/network /etc/sysconfig/network

#shutdown guest (user needs to restart to continue to building)

echo "Please shutdown the guest with vagrant halt and restart into gui"


