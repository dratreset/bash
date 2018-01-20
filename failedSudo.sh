#!/bin/bash

####################
#
#	Sudo failures; Lists users that attempt to sudo
#	a command that they do not have permission to sudo.
#
#	Author: Rob Thompson
#
####################

logFile='/root/serverLogs/failedSudo.txt'

printf "\n===========================================================================================\n" >> $logFile
date >> $logFile
printf "\n" >> $logFile
journalctl -r | grep 'sudo.*command not allowed' >> $logFile
printf "\n\n" >> $logFile
