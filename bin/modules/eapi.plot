
plotcommand="plot "
for (( x = 0 ; x < 7 ; x++ )); do
	plotcommand+=" \"${modlog}\" using 1:(\$$((x+2))+0.001) with lines title \"EAPI ${x}\" lw 2 lt $((${x}%8+1)) lc ${x}, "
done
x=7
plotcommand+=" \"${modlog}\" using 1:(\$$((x+2))+0.001) with lines title \"EAPI ${x}\" lw 2 lt $((${x}%8+1)) lc ${x}"


gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
unset logscale y
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set yrange [ 0 : * ] noreverse nowriteback 
set output "${modwebdir}/${scope}.ps"
${plotcommand}

THEGNUPLOTSCRIPTHERE

gnuplot <<THEGNUPLOTSCRIPTLOGHERE

load "${moddir}/plotdefaults"
set logscale y
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set yrange [ 1 : * ] noreverse nowriteback 
set output "${modwebdir}/${scope}-log.ps"
${plotcommand}

THEGNUPLOTSCRIPTLOGHERE
