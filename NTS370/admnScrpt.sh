#!/bin/bash

########################
#
#	Admin Script
#	Author: Robert Thompson
#
########################
#
#	Description:	Administrative script with two primary functions.
#
#			Funciton 1:	SSH Management. Prompts the user whether or not the script should warn the logged in
#					users that the SSH service is going down. If yes is selected, the administrator has
#					the option to provide a custom broadcast message (simple text file is accepted). The
#					administrator is then prompted for a deadline (in minutes), at which point the SSH daemon
#					will be stopped. Message will be broadcast every 2 minutes.
#
#			Function 2:	System Updates/Upgrades. Administrator may select which OS the script is being run on to
#					perform updates. Current supported platforms:
#						-Ubuntu/Debian
#						-SELinux (yum & dnf)
#						-Arch
#
########################

RED='\033[0;31m'	# Colors
YLLW='\033[1;33m'	#
GRN='\033[0;32m'	#
NOCOLOR='\033[0m'	#


if [ $EUID -ne 0 ];then			# Forces to run as root
	echo "Run as root pl0x!"
	exit
fi


wallFunc() {			# Function for broadcast messages

if [[ $2 == 0 ]];then
	for (( i=$1; i>0; i=i-2 ))
	do
		defaultMessage="MESSAGE FROM ADMINISTRATOR: SSH Service is being shutdown for server maintenance. $i minutes remaining."
		wall $defaultMessage
		sleep 120
	done

else
	for (( i=$1; i>0; i=i-2 ))
	do
		cat $3 | wall	# Concatenates third argument passed into function (text file) to be piped
		sleep 120	# into wall (message broadcasting command)
	done
fi
}

menu=true		# Bool logic to keep the menu
			# active and allow invalid
while $menu;do		# input to loop back

	printf "\t\t+++++ Admin Script +++++\n\nSelect and option:\n\n1)Shut down SSH\n2)Update & Reboot\n3)Exit\n\nEntry: "
	read answer		# Main menu

	case $answer in		# Case statement for options

	1)	oneBool=true	# Option one SSH service management
		while $oneBool;do
			printf "Warn users? (${GRN}Y${NOCOLOR}/n) "
			read oneAnswerOne

			if [[ "${oneAnswerOne}" =~ [yY] ]] || [ -z "$oneAnswerOne" ];then	# Regex in if-statement to cover upper
				oneBool=false							# and lower casing; || second option blank
				twoBool=true							# to accept default (highlighted and upper
												# case when run)
				while $twoBool;do
					printf "Use personalized message? (y/${GRN}N${NOCOLOR}) "
					read perMess

					if [[ "${perMess}" =~ [yY] ]];then
						messBool=1
						printf "Enter full ${GRN}filepath${NOCOLOR} to message: "
						read filePath

						if [ -f $filePath ];then
							printf "File exists!\n"
							twoBool=false
							printf "Personal broadcast message will be sent to users. ${GRN}Enter deadline ${YLLW}(minutes)${NOCOLOR}: "
							read intMin
							wallFunc "$intMin" "$messBool" "$filePath"	# Function call, see above
							systemctl stop sshd	# Shutting down SSH

						else		# Else-statement for file existence check
							printf "File does not exist! Check path and enter again.\n"


						fi

					elif [[ "${perMess}" =~ [nN] ]] || [ -z "$perMess" ];then
						messBool=0
						printf "Default broadcast message will be sent to users. ${GRN}Enter deadline ${YLLW}(minutes)${NOCOLOR}: "
						read intMin
						twoBool=false
						wallFunc "$intMin" "$messBool"		# Function call, see above
						systemctl stop sshd		# Shutting down SSH


					fi


				done

			elif [[ "${oneAnswerOne}" =~ [nN] ]];then							# This block exists as a warning if
				printf "Users ${RED}WILL NOT${NOCOLOR} be warned and all sessions will be terminated! "	# the administrator chooses not to
				read -p "Press <Enter> to continue or Ctrl+C to cancel."				# inform the users and wants to shut
				oneBool=false										# down SSH immediately
				systemctl stop sshd

			else
				echo "That was not an option. Try again."	# Else-statement error checking typos (non-yn)


			fi


		done
		;;


	2)	twoBool=true		# Option two, server updates

		while $twoBool;do
			printf "Select OS\n\n1) Ubuntu/Debian\n2) SELinux (yum)\n3) SELinux (dnf)\n4) Arch\n\nEntry: "
			read osAnswer
			printf "${GRN}You may have to confirm, please ${YLLW}stand-by.${NOCOLOR}\n"

			case $osAnswer in	# Basic case-statement for multiple OS platforms.

			1)	twoBool=false
				apt-get update && apt-get upgrade && reboot
				;;

			2)	twoBool=false
				yum update && reboot
				;;

			3)	twoBool=false
				dnf update && reboot
				;;

			4)	twoBool=false
				pacman -Syu && reboot
				;;


			esac


		done

		;;


	3)	exit ;;


	esac


done
