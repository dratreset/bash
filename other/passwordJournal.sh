#!/bin/bash

####################
#
#	Password Failures for logins
#	Author: Rob Thompson
#
####################

logFile='/root/serverLogs/failedLogins.txt'

printf "\n===========================================================================================\n" >> $logFile
date >> $logFile
printf "\n" >> $logFile
journalctl -r | grep "Failed password" >> $logFile
printf "\n\n" >> $logFile
