
plotcommand="plot \"${modlog}\" using 2:(1*(\$3+\$4+\$5+\$6)/1024/1024) with lines title \"total\" lw 4, "
for (( x = 3 ; x < 6 ; x++ )); do
	plotcommand+=" \"${modlog}\" using 2:(1*(\$${x})/1024/1024) with lines title \"${mirrors_columns[$((x-2))]}\" lw 2 lt $((${x}%8+1)) lc ${x}, "
done
x=6
plotcommand+=" \"${modlog}\" using 2:(1*(\$${x})/1024/1024) with lines title \"${mirrors_columns[$((x-2))]}\" lw 2 lt $((${x}%8+1)) lc ${x}"

gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
set colors classic
unset logscale y
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set yrange [ 0 : * ] noreverse nowriteback 
set output "${modwebdir}/total-${scope}.ps"
${plotcommand}

THEGNUPLOTSCRIPTHERE





plotcommand="plot "
for (( x = 7 ; x < 33 ; x = x + 2 )); do
	plotcommand+=" \"${modlog}\" using 2:(1*(\$${x})/1024/1024) with lines title \"${mirrors_columns[$((x-2))]%/autobuilds}\" lw 2 lt $((${x}%8+1)) lc ${x} dt $(( (${x}-7)/16+1 )), "
done
x=33
plotcommand+=" \"${modlog}\" using 2:(1*(\$${x})/1024/1024) with lines title \"${mirrors_columns[$((x-2))]%/autobuilds}\" lw 2 lt $((${x}%8+1)) lc ${x} dt $(( (${x}-7)/16+1 ))"

gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
set colors classic
unset logscale y
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set yrange [ 0 : * ] noreverse nowriteback 
set output "${modwebdir}/autobuilds-${scope}.ps"
${plotcommand}

THEGNUPLOTSCRIPTHERE




plotcommand="plot "
for (( x = 8 ; x < 33 ; x = x + 2 )); do
	plotcommand+=" \"${modlog}\" using 2:(1*(\$${x})/1024/1024) with lines title \"${mirrors_columns[$((x-2))]%/binpackages}\" lw 2 lt $((${x}%8+1)) lc ${x} dt $(( (${x}-8)/16+1 )), "
done
x=34
plotcommand+=" \"${modlog}\" using 2:(1*(\$${x})/1024/1024) with lines title \"${mirrors_columns[$((x-2))]%/binpackages}\" lw 2 lt $((${x}%8+1)) lc ${x} dt $(( (${x}-8)/16+1 ))"

gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
set colors classic
unset logscale y
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set yrange [ 0 : * ] noreverse nowriteback 
set output "${modwebdir}/binpackages-${scope}.ps"
${plotcommand}

THEGNUPLOTSCRIPTHERE



