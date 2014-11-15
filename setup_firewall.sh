#!/bin/bash

if ! grep -qi "debian" /etc/issue
then
        echo "This script can only be run on Debian Linux."
        exit 1
fi



[ -f /etc/apf/conf.apf ] && { echo "Advanced Policy Firewall already installed." ; exit 1 ;}

if [ ! -d /etc/apf/ ]
then
        [ ! -d /root/download ] && mkdir /root/download
        cd /root/download
        wget http://www.rfxn.com/downloads/apf-current.tar.gz
        tar xvfz apf-current.tar.gz
        cd apf-*
        ./install.sh
fi

wget -O /etc/apf/conf.apf https://raw.githubusercontent.com/Koniii/apf2/master/conf.apf
chmod 640 /etc/apf/conf.apf

wget -O /etc/init.d/apf https://raw.githubusercontent.com/Koniii/apf2/master/apf-firewall
chmod 755 /etc/init.d/apf

insserv apf
service apf restart

exit 0
