#
# Script to move library dependencies of specific commands and functions in shell
# environments to the CHROOT jail. Script found here:
#	https://linuxconfig.org/how-to-automatically-chroot-jail-selected-ssh-user-logins
#
##################################################################################################
#
# *** TO RUN: arguments should be full file paths of the commands you want to give chroot
# *** jailed users. [ Example: ./chrootSetup.sh /bin/{ls,dd,nano} /usr/bin/vi /etc/hosts ]
#						     ^- - - - - ^ - - -These brackets are necessary
#
# *** Furthermore: Once run, you can not run it again; have a complete list of commands/software
# *** that you wish to apply to the jails.
#
##################################################################################################
#
# Revision by: Rob Thompson
#

CHROOT='/var/chroot/base'
mkdir $CHROOT

for i in $( ldd $* | grep -v dynamic | cut -d " " -f 3 | sed 's/://' | sort | uniq )
	do
		cp --parents $i $CHROOT
	done

if [ -f /lib64/ld-linux-x86-64.so.2 ]; then
	cp --parents /lib64/ld-linux-x86-64.so.2 /$CHROOT
fi

if [ -f /lib/ld-linux.so.2 ]; then
	cp --parents /lib/ld-linux.so.2 /$CHROOT
fi

echo "Done bro."

