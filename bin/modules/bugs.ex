#!/bin/bash

source ${moddir}/bugs.config

for ((x=0; x<${#bugmails[*]}; x++)); do

	if [ "x${bugmails[$x]}" = "x" ]; then
		number=x
	else
		number=`wget -q -O - ${urlpart1}${bugmails[$x]}${urlpart2} | wc -l `
		if [ "x$number" = "x0" ]; then
			number=x
		fi
	fi

	echo -n "$number	"
	sleep 1m

done
