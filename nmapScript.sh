#!/bin/bash

####################
#
#	Simple Port Scan Script
#	Author: Robert Thompson
#
####################
#
#	Usage:	Script iterates over given values
#		and outputs results into textfile.
#
####################


printf "==================================================\n\tWelcome\n\nEnter first IP address: "
read firstIP

printf "Enter last IP address: "
read lastIP

printf "\n"

for ((i=$firstIP; i<$lastIP+1; i++))
do
	echo "Scanning 10.10.160.$i..."
	sudo nmap -sN 10.10.160.$i >> output.txt
done

printf "\n==================================================\n"
