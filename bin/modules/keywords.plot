#!/bin/bash

has() {
        hasq "$@"
}

hasq() {
        [[ " ${*:2} " == *" $1 "* ]]
}

source ${modconf}

for al in major prefix freebsd; do 

plotcommand="plot "
for (( x = 1 ; x < ${#columns[*]} ; x++ )); do

	alarchlistname=`echo archlist_$al[\*]`
	alarchlist=${!alarchlistname}

	curarch="`echo ${columns[$x]} | sed -e 's:^.*for_::'`"
	kwst=`echo ${columns[$x]} | sed -e 's:_.*$::g' -e 's:^stable.*::g'`

	if [[ -n ${kwst} ]] ; then
		# echo \"$curarch\" in \"$alarchlist\"
		if $(hasq ${curarch} ${alarchlist}) ; then 
			# echo "adding \"${curarch}\" \"$kwst\" to plot"
			plotcommand+=" \"${modlog}\" using 1:$((x+2)) with lines title \"${columns[$x]//_/ }\" lw 2 lt $((${x}%8+1)) lc ${x}, "
		fi
	fi
done
plotcommand+=" \"${modlog}\" using 1:2 with lines title \"${columns[0]//_/ }\" lw 3 lt 1 lc 0"

# generate the overview plot

gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set yrange [ 1 : 40000 ] noreverse nowriteback
set logscale y
set output "${modwebdir}/${scope}-${al}.ps"
${plotcommand}

THEGNUPLOTSCRIPTHERE

done

# generate the plot for full number of ebuilds

x=0

gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set output "${modwebdir}/$scope-$x.ps"
unset logscale y
set yrange [0:*]
plot "${modlog}" using 1:$((x+2)) with lines title "${columns[$x]//_/ }" lw 1.5 lt 5

THEGNUPLOTSCRIPTHERE

# generate the detail plots

for ((x=1; x<${#columns[*]}; x+=2)); do
	
gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set output "${modwebdir}/$scope-$x.ps"
unset logscale y
set yrange [0:*]
plot "${modlog}" using 1:$((x+2)) with lines title "${columns[$((x))]//_/ }" lw 1.5 lt 6, \
     "${modlog}" using 1:$((x+3)) with lines title "${columns[$((x+1))]//_/ }" lw 1.5 lt 5

THEGNUPLOTSCRIPTHERE

done

