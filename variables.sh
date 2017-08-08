#!/bin/bash

##################
#
#	Variable Usage Script 1.0
#	Author: Rob Thompson
#
##################
#
#	Usage: Run the script and answer the prompts as they appear.
#
#
##################

SNAME="UAT"	# Setting constant for UAT.

printf "\n\n=================================================\n\nWelcome.\n\nWhat is your name?\n"	# Welcomes user, Decided printf looked friendlier
													# to the user with less code, provides first prompt
read -p "Name: " UNAME					#
printf "And what is the cource you are taking?\n"	# Stores answers in variables
read -p "Course Code: " CNAME				#

echo "Hello $UNAME, you are currently enrolled in $CNAME here at $SNAME. Good luck this semester!"	# Output variables stored

printf "\n=================================================\n\n"	# The "\n" switches cause bash to
									# print a new line.

######
#
#	Side note:	If this comment structure is too messy for you, inform me. Will make effort to change structure in future.
#			It's readable to me, but might not be to others.
#
######
