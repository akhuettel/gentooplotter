#!/bin/bash

source ${moddir}/bugs.config

for ((x=0; x<${#URLs[*]}; x++)); do

	if [ "x${URLs[$x]}" = "x" ]; then
		number=x
	else
		number=`wget -q -O - ${URLs[$x]} | wc -l `
		if [ "x$number" = "x0" ]; then
			number=x
		fi
	fi

	echo -n "$number	"
	sleep 1m

done
