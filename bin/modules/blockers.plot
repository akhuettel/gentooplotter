
plotcommand="plot "
#for (( x = 0 ; x < 2 ; x=x+2 )); do
#	plotcommand+=" \"${modlog}\" using 1:(\$$((x+1))+0.001) with lines title \"${blockers_bugs[$((x+1))]}\" lw 2 lt $((${x}%8+1)) lc ${x}, "
#done
x=0
plotcommand+=" \"${modlog}\" using 1:(\$$((x+1))+0.001) with lines title \"${blockers_bugs[$((x+1))]}\" lw 2 lt $((${x}%8+1)) lc ${x}, "

gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
unset logscale y
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set yrange [ 0 : * ] noreverse nowriteback 
set output "${modwebdir}/${scope}.ps"
${plotcommand}

THEGNUPLOTSCRIPTHERE
