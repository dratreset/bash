#!/bin/bash

#####
#
#	Modified Ruby Install Script
#	Original Author: https://www.cyberciti.biz/tips/linux-unix-shell-batch-copy.html
#	Revised and repurposed by: Robert Thompson
#
#####
#
#	Usage:	Script, when run, will clone the ruby github page and iterate over existing
#		users and copy the files into their home directories. It will then change
#		owner of rubys files, and its children. It is recommended to run this script
#		as root to avoid permission conflicts. Sudo usage has not been tested.
#
#####


uhome="/home"
file="/root/tmp/.rbenv/"
sfile=".rbenv/"
users="$(awk -F ':' '{ if ( $3 >= 1000 ) print $1 }' /etc/passwd)"

cd ~
mkdir /root/tmp/
git clone https://github.com/rbenv/rbenv.git /root/tmp/.rbenv
git clone https://github.com/rbenv/ruby-build.git /root/tmp/.rbenv/plugins/ruby-build

for u in $users
do
	dir="${uhome}/${u}"
	if [ -d "$dir" ]
	then
		/bin/cp -r "$file" "$dir"
		chown -R $(id -un $u):$(id -gn $u) "$dir/${sfile}"
	fi

	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $dir/.bashrc
	echo 'eval "$(rbenv init -)"' >> $dir/.bashrc

	runuser -l $u -c 'source ~/.bashrc'
done
