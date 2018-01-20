#!/bin/bash

############
#
#	Quick User Script
#	Author: Rob Thompson
#	Creates $1 users, their home directories, and adds to SSH whitelist
#
#	Example: ./userScript 4
#		 |_____________|---- Creates 4 users.
#
############

if [ $EUID -ne 0 ]; then
	echo "Run as root nimrod."
	exit
fi


NUMUSERS=$1

for (( u=1; u<=$1; u++ ))
	do
		read -p "Enter Username: " UNAME
		useradd -s /bin/bash -p $(openssl passwd -1 changeme) -m $UNAME
		chage -d0 $UNAME
		usermod -a -G sshstudents $UNAME
		echo "$UNAME added."
	done
