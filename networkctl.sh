#!/bin/bash

if [ $EUID -ne 0 ];then
	echo "Run as root, numbskull."
	exit
fi


break="===================================================================================================="


printf "###	Network Controller	###\n\n1) Start\n2) Stop\n\nEntry: "
read selection

echo -n "Working Profile: "
read profile


if [ $selection == 1 ];then

	echo -n "Desired interface: "
	read inf

	echo -n "Generate random MAC? (y/n): "
	read ranMAC

	echo $break

	if [ $ranMAC == "y" ];then
		echo "Generating random MAC..."
		ifconfig $inf down
		macchanger -r $inf
	fi

	echo $break

	echo "Starting $inf interface..."

	cd /etc/netctl
	netctl start $profile
	ip a

	echo $break

	echo "Restoring default IPTables Rules..."
	iptables-restore < /etc/iptables/customRules/default.rules
	iptables -L

	exit

fi


if [ $selection == 2 ];then
	echo "Stopping interface..."

	cd /etc/netctl
	netctl stop $profile

	exit

fi
