gnuplot <<THEGNUPLOTSCRIPTHERE

load "${moddir}/plotdefaults"
unset logscale y
set xrange [ $((${timefrom}-${stupidgnuplotoffset})) : $((${now}-${stupidgnuplotoffset})) ]
set yrange [ 0 : * ] noreverse nowriteback 
set output "${modwebdir}/${scope}.ps"
plot "${modlog}" using 1:2 with lines title "fedorahosted.org ebuilds" lw 2 lt 1 lc 2

THEGNUPLOTSCRIPTHERE
