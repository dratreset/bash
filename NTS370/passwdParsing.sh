#!/bin/bash

#####################
#
#	/etc/passwd User Environment Script
#	Author: Rob Thompson
#
#####################
#
#	Usage: Running the script will execute this one-liner and
#	output the data into a new text-file present in the same
#	directory as the script. It will overwrite the same file
#	each time it's ran.
#
#####################

cat /etc/passwd | awk -F ':' '{print $1, $6, $7}' | sort > currentUserEnvs.txt
