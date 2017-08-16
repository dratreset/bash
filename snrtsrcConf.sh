#!/bin/bash

#######################################
#
#	Snort Conf Setup
#	Author: Rob Thompson
#
#	Use: 	After compiling snort from source, running this script will
#		create the necessary directories and log files Snort needs.
#		Must run as root/sudo for permissions to be edited.
#
#######################################


if [ $EUID -ne 0 ];then
	echo "Run as root pl0x."
	exit
fi

spacer="===================================================================================="
RED='\033[0;31m'
YLLW='\033[1;33m'
GRN='\033[0;32m'
NOCOLOR='\033[0m'

printf "${YLLW}"
echo $spacer
printf "\n${RED}WARNING: ${YLLW}Make sure you have the full file path of Snort's source code\nhandy before running this script!\n\n"
echo $spacer

printf "\n${NOCOLOR}Enter the full file-path of Snort's source. I.E. the directory that\ncontains \"snort-2.X.X.X\" including that directory: "
read snrtSrcDir


if [ -d $snrtSrcDir ];then
	echo "Directory exists."
else
	echo "Directory does not exist. Check your filepath and run again."
	exit
fi


echo $spacer
printf "\nCreating /etc directories and rules files..."

mkdir /etc/snort /etc/snort/rules /etc/snort/rules/iplists /etc/snort/preproc_rules /etc/snort/so_rules
touch /etc/snort/local.rules /etc/snort/rules/iplists/black_list.rules /etc/snort/rules/iplists/white_list.rules /etc/snort/sid.msg.map


printf "\nCreating log directories...\n"

mkdir /usr/local/lib/snort_dynamicrules /var/log/snort /var/log/snort/archived_logs


printf "\nCreating snort user/group...\n"

groupadd snort
useradd -r snort -s /sbin/nologin -g snort


printf "\nEditing permissions of all snort directories...\n"

chown -R snort:snort /etc/snort
chown -R snort:snort /var/log/snort
chown -R snort:snort /usr/local/lib/snort_dynamicrules

chmod -R 5775 /etc/snort
chmod -R 5775 /var/log/snort
chmod -R 5775 /var/log/snort/archived_logs
chmod -R 5775 /etc/snort/so_rules
chmod -R 5775 /usr/local/lib/snort_dynamicrules


printf "\nCopying general config files from source...\n"

cp $snrtSrcDir/etc/*.conf /etc/snort/
cp $snrtSrcDir/etc/*.config /etc/snort/
cp $snrtSrcDir/etc/*.map /etc/snort/
cp $snrtSrcDir/etc/*.dtd /etc/snort/

cp $snrtSrcDir/src/dynamic-preprocessors/build/usr/local/lib/snort_dynamicpreprocessor/* /usr/local/lib/snort_dynamicpreprocessor


echo $spacer

printf "\n${GRN}Snort setup complete. If no ${RED}errors ${GRN}occurred, you can now configure\nSnort to capture traffic. It is highly recommended you review the ${YLLW}output ${GRN}as well \nas your ${YLLW}/etc ${GRN}folders to ensure you have all the necessary files.\n\n${NOCOLOR}"
