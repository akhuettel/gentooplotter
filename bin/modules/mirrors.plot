
plotcommand="plot \"${modlog}\" using 2:(\$3+\$4+\$5+\$6) with lines title \"total\" lw 4, "
for (( x = 3 ; x < 6 ; x++ )); do
	plotcommand+=" \"${modlog}\" using 2:(\$${x}) with lines title \"${mirrors_columns[$((x-2))]}\" lw 2 lt $((${x}%8+1)) lc ${x}, "
done
x=6
plotcommand+=" \"${modlog}\" using 2:(\$${x}) with lines title \"${mirrors_columns[$((x-2))]}\" lw 2 lt $((${x}%8+1)) lc ${x}"

gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
unset logscale y
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set yrange [ 0 : * ] noreverse nowriteback 
set ylabel "kByte"
set output "${modwebdir}/total-${scope}.ps"
${plotcommand}

THEGNUPLOTSCRIPTHERE
