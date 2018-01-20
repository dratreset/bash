#!/bin/bash

##########################
#
#	FizzBuzz Challenge
#	Author: Robert Thompson
#
##########################
#
#	Usage:	Run the script like normal; it will iterate over
#		numbers between 1 and 100 and print out Fizz if
#		the number is divisible by 3, Buzz if the number
#		is divisible by 5, FizzBuzz if divisible by both.
#
##########################

for (( i=1; i<101; i++ ));
do
	j=$(($i%3))	### variables "j" and "k" are being set to the result of the modulus equation.
	k=$(($i%5))	### If the result is equal to 0, the variable "i" is divisible by the divisor.

#	printf "$i\n"

	if [ $j = 0 ] && [ $k = 0 ]; then
		printf "$i FizzBuzz\n"		###
						#	This section, while simple, was a pain in my neck.
	elif [ $j = 0 ]; then			#	Bash interprets stuff in a weird way; this if-elif
		printf "$i Fizz\n"		#	block -must- be in this order -- if both "j" and "k"
						#	are 0, but the logical-and is not checked first, it
	elif [ $k = 0 ]; then			#	won't work properly.
		printf "$i Buzz\n"		###

	else
		printf "$i\n"

	fi
done
