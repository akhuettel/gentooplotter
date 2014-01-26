#!/bin/bash

has() {
        hasq "$@"
}

hasq() {
        [[ " ${*:2} " == *" $1 "* ]]
}

source /home/huettel/bin/gentoo-tree-report.conf




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
			plotcommand+=" \"$logfile\" using 1:$((x+2)) with lines title \"${columns[$x]//_/ }\" lw 2 lt $((${x}%8+1)) lc ${x}, "
		fi
	fi
done
plotcommand+=" \"$logfile\" using 1:2 with lines title \"${columns[0]//_/ }\" lw 3 lt 1 lc 0"


# generate the overview plot


gnuplot <<THEGNUPLOTSCRIPTHERE

set terminal postscript portrait noenhanced defaultplex \
   leveldefault color colortext \
   dashed dashlength 1.5 linewidth 1.0 butt noclip \
   palfuncparam 2000,0.003 \
   "Helvetica" 9
set output "$PLOTBASE-$scope-$al.ps"
unset clip points
set clip one
unset clip two
set bar 1.000000 front
set border 31 front linetype -1 linewidth 1.000
set xdata time
set ydata
set zdata
set x2data
set y2data
set timefmt x "%s"
set timefmt y "%s"
set timefmt z "%s"
set timefmt x2 "%s"
set timefmt y2 "%s"
set timefmt cb "%s"
set boxwidth
set style fill  empty border
set style rectangle back fc lt -3 fillstyle   solid 1.00 border lt -1
set dummy x,y
set format x "% g"
set format y "% g"
set format x2 "% g"
set format y2 "% g"
set format z "% g"
set format cb "% g"
set angles radians
unset grid
set grid ytics
set key title ""
set key inside left bottom vertical Right noreverse enhanced autotitles box
set key noinvert samplen 4 spacing 1 width 0 height 0 
unset label
unset arrow
set style increment default
unset style line
unset style arrow
set style histogram clustered gap 2 title  offset character 0, 0, 0
unset logscale
set offsets 0, 0, 0, 0
set pointsize 1
set encoding default
unset polar
unset parametric
unset decimalsign
set view 60, 30, 1, 1  
set samples 100, 100
set isosamples 10, 10
set surface
unset contour
set clabel '%8.3g'
set mapping cartesian
set datafile separator whitespace
unset hidden3d
set cntrparam order 4
set cntrparam linear
set cntrparam levels auto 5
set cntrparam points 5
set size ratio 0 1,1
set origin 0,0
set style data points
set style function lines
set xzeroaxis linetype -2 linewidth 1.000
set yzeroaxis linetype -2 linewidth 1.000
set zzeroaxis linetype -2 linewidth 1.000
set x2zeroaxis linetype -2 linewidth 1.000
set y2zeroaxis linetype -2 linewidth 1.000
set ticslevel 0.5
set mxtics default
set mytics 10
set mztics default
set mx2tics default
set my2tics default
set mcbtics default
set xtics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0
set xtics autofreq  norangelimit
set ytics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0
set ytics autofreq  norangelimit
set ztics border in scale 1,0.5 nomirror norotate  offset character 0, 0, 0
set ztics autofreq  norangelimit
set nox2tics
set noy2tics
set cbtics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0
set cbtics autofreq  norangelimit
set title "" 
set title  offset character 0, 0, 0 font "" norotate
set timestamp bottom 
set timestamp "" 
set timestamp  offset character 0, 0, 0 font "" norotate
set rrange [ * : * ] noreverse nowriteback  # (currently [8.98847e+307:-8.98847e+307] )
set trange [ * : * ] noreverse nowriteback  # (currently ["":""] )
set urange [ * : * ] noreverse nowriteback  # (currently ["":""] )
set vrange [ * : * ] noreverse nowriteback  # (currently [-10.0000:10.0000] )
set xlabel "" 
set xlabel  offset character 0, 0, 0 font "" textcolor lt -1 norotate
set x2label "" 
set x2label  offset character 0, 0, 0 font "" textcolor lt -1 norotate
#set xrange [ * : * ] noreverse nowriteback  # (currently ["":""] )

set xrange [ "${timefrom}" : * ]

set x2range [ * : * ] noreverse nowriteback  # (currently [3.23624e+08:3.23624e+08] )
set ylabel "" 
set ylabel  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set y2label "" 
set y2label  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270

set yrange [ * : 40000 ] noreverse nowriteback  # (currently [70.0000:80.0000] )

set y2range [ * : * ] noreverse nowriteback  # (currently [74.2500:75.7500] )
set zlabel "" 
set zlabel  offset character 0, 0, 0 font "" textcolor lt -1 norotate
set zrange [ * : * ] noreverse nowriteback  # (currently [-10.0000:10.0000] )
set cblabel "" 
set cblabel  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set cbrange [ * : * ] noreverse nowriteback  # (currently [8.98847e+307:-8.98847e+307] )
set zero 1e-08
set lmargin  8
set bmargin  7
set rmargin  -1
set tmargin  -1
set locale "de_DE.UTF-8"
set pm3d explicit at s
set pm3d scansautomatic
set pm3d interpolate 1,1 flush begin noftriangles nohidden3d corners2color mean
set palette positive nops_allcF maxcolors 0 gamma 1.5 color model RGB 
set palette rgbformulae 7, 5, 15
set colorbox default
set colorbox vertical origin screen 0.9, 0.2, 0 size screen 0.05, 0.6, 0 front bdefault
set loadpath 
set fontpath
set fit noerrorvariables
GNUTERM = "x11"

set logscale y
set format x "%Y/%m/%d"
set xtics rotate by -35


${plotcommand}
#    EOF

THEGNUPLOTSCRIPTHERE


# convert the overview plot to png and copy it to the webdir


convert -alpha on -negate -density 300 -geometry $OUTPUTSIZE $PLOTBASE-$scope-$al.ps $PLOTBASE-$scope-$al.png
cp $PLOTBASE-$scope-$al.png $WEBDIR





done









# generate the plot for full number of ebuilds


x=0


	gnuplot <<THEGNUPLOTSCRIPTHERE

set terminal postscript eps noenhanced defaultplex \
   leveldefault color colortext \
   solid dashlength 1.0 linewidth 1.0 butt noclip \
   palfuncparam 2000,0.003 \
   "Helvetica" 17
set output "$PLOTBASE-$scope-$x.ps"
unset clip points
set clip one
unset clip two
set bar 1.000000 front
set border 31 front linetype -1 linewidth 1.000
set xdata time
set ydata
set zdata
set x2data
set y2data
set timefmt x "%s"
set timefmt y "%s"
set timefmt z "%s"
set timefmt x2 "%s"
set timefmt y2 "%s"
set timefmt cb "%s"
set boxwidth
set style fill  empty border
set style rectangle back fc lt -3 fillstyle   solid 1.00 border lt -1
set dummy x,y
set format x "% g"
set format y "% g"
set format x2 "% g"
set format y2 "% g"
set format z "% g"
set format cb "% g"
set angles radians
unset grid
set grid ytics
set key title ""
set key inside right top vertical Right noreverse enhanced autotitles nobox
set key noinvert samplen 4 spacing 1 width 0 height 0 
unset label
unset arrow
set style increment default
unset style line
unset style arrow
set style histogram clustered gap 2 title  offset character 0, 0, 0
unset logscale
set offsets 0, 0, 0, 0
set pointsize 1
set encoding default
unset polar
unset parametric
unset decimalsign
set view 60, 30, 1, 1  
set samples 100, 100
set isosamples 10, 10
set surface
unset contour
set clabel '%8.3g'
set mapping cartesian
set datafile separator whitespace
unset hidden3d
set cntrparam order 4
set cntrparam linear
set cntrparam levels auto 5
set cntrparam points 5
set size ratio 0 1,1
set origin 0,0
set style data points
set style function lines
set xzeroaxis linetype -2 linewidth 1.000
set yzeroaxis linetype -2 linewidth 1.000
set zzeroaxis linetype -2 linewidth 1.000
set x2zeroaxis linetype -2 linewidth 1.000
set y2zeroaxis linetype -2 linewidth 1.000
set ticslevel 0.5
set mxtics default
set mytics 2
set mztics default
set mx2tics default
set my2tics default
set mcbtics default
set xtics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0
set xtics autofreq  norangelimit
set ytics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0
set ytics autofreq norangelimit
set ztics border in scale 1,0.5 nomirror norotate  offset character 0, 0, 0
set ztics autofreq  norangelimit
set nox2tics
set noy2tics
set cbtics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0
set cbtics autofreq  norangelimit
set title "" 
set title  offset character 0, 0, 0 font "" norotate
set timestamp bottom 
set timestamp "" 
set timestamp  offset character 0, 0, 0 font "" norotate
set rrange [ * : * ] noreverse nowriteback  # (currently [8.98847e+307:-8.98847e+307] )
set trange [ * : * ] noreverse nowriteback  # (currently ["":""] )
set urange [ * : * ] noreverse nowriteback  # (currently ["":""] )
set vrange [ * : * ] noreverse nowriteback  # (currently [-10.0000:10.0000] )
set xlabel "" 
set xlabel  offset character 0, 0, 0 font "" textcolor lt -1 norotate
set x2label "" 
set x2label  offset character 0, 0, 0 font "" textcolor lt -1 norotate
#set xrange [ * : * ] noreverse nowriteback  # (currently ["":""] )

set xrange [ "${timefrom}" : * ]

set x2range [ * : * ] noreverse nowriteback  # (currently [3.23624e+08:3.23624e+08] )
set ylabel "" 
set ylabel  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set y2label "" 
set y2label  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set yrange [ * : * ] noreverse nowriteback  # (currently [70.0000:80.0000] )
set y2range [ * : * ] noreverse nowriteback  # (currently [74.2500:75.7500] )
set zlabel "" 
set zlabel  offset character 0, 0, 0 font "" textcolor lt -1 norotate
set zrange [ * : * ] noreverse nowriteback  # (currently [-10.0000:10.0000] )
set cblabel "" 
set cblabel  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set cbrange [ * : * ] noreverse nowriteback  # (currently [8.98847e+307:-8.98847e+307] )
set zero 1e-08
set lmargin  8
set bmargin  7
set rmargin  -1
set tmargin  -1
set locale "de_DE.UTF-8"
set pm3d explicit at s
set pm3d scansautomatic
set pm3d interpolate 1,1 flush begin noftriangles nohidden3d corners2color mean
set palette positive nops_allcF maxcolors 0 gamma 1.5 color model RGB 
set palette rgbformulae 7, 5, 15
set colorbox default
set colorbox vertical origin screen 0.9, 0.2, 0 size screen 0.05, 0.6, 0 front bdefault
set loadpath 
set fontpath
set fit noerrorvariables
GNUTERM = "x11"

set xtics rotate by -35
set format x "%Y/%m/%d"
plot "$logfile" using 1:$((x+2)) with lines title "${columns[$x]//_/ }" lw 1.5 lt 5
#    EOF

THEGNUPLOTSCRIPTHERE

	convert -alpha on -negate -density 300 -geometry $OUTPUTSIZE $PLOTBASE-$scope-$x.ps $PLOTBASE-$scope-$x.png
	cp $PLOTBASE-$scope-$x.png $WEBDIR











# generate the detail plots



for ((x=1; x<${#columns[*]}; x+=2)); do
	
	gnuplot <<THEGNUPLOTSCRIPTHERE

set terminal postscript eps noenhanced defaultplex \
   leveldefault color colortext \
   solid dashlength 1.0 linewidth 1.0 butt noclip \
   palfuncparam 2000,0.003 \
   "Helvetica" 17
set output "$PLOTBASE-$scope-$x.ps"
unset clip points
set clip one
unset clip two
set bar 1.000000 front
set border 31 front linetype -1 linewidth 1.000
set xdata time
set ydata
set zdata
set x2data
set y2data
set timefmt x "%s"
set timefmt y "%s"
set timefmt z "%s"
set timefmt x2 "%s"
set timefmt y2 "%s"
set timefmt cb "%s"
set boxwidth
set style fill  empty border
set style rectangle back fc lt -3 fillstyle   solid 1.00 border lt -1
set dummy x,y
set format x "% g"
set format y "% g"
set format x2 "% g"
set format y2 "% g"
set format z "% g"
set format cb "% g"
set angles radians
unset grid
set grid ytics
set key title ""
set key inside right top vertical Right noreverse enhanced autotitles nobox
set key noinvert samplen 4 spacing 1 width 0 height 0 
unset label
unset arrow
set style increment default
unset style line
unset style arrow
set style histogram clustered gap 2 title  offset character 0, 0, 0
unset logscale
set offsets 0, 0, 0, 0
set pointsize 1
set encoding default
unset polar
unset parametric
unset decimalsign
set view 60, 30, 1, 1  
set samples 100, 100
set isosamples 10, 10
set surface
unset contour
set clabel '%8.3g'
set mapping cartesian
set datafile separator whitespace
unset hidden3d
set cntrparam order 4
set cntrparam linear
set cntrparam levels auto 5
set cntrparam points 5
set size ratio 0 1,1
set origin 0,0
set style data points
set style function lines
set xzeroaxis linetype -2 linewidth 1.000
set yzeroaxis linetype -2 linewidth 1.000
set zzeroaxis linetype -2 linewidth 1.000
set x2zeroaxis linetype -2 linewidth 1.000
set y2zeroaxis linetype -2 linewidth 1.000
set ticslevel 0.5
set mxtics default
set mytics 2
set mztics default
set mx2tics default
set my2tics default
set mcbtics default
set xtics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0
set xtics autofreq  norangelimit
set ytics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0
set ytics autofreq norangelimit
set ztics border in scale 1,0.5 nomirror norotate  offset character 0, 0, 0
set ztics autofreq  norangelimit
set nox2tics
set noy2tics
set cbtics border in scale 1,0.5 mirror norotate  offset character 0, 0, 0
set cbtics autofreq  norangelimit
set title "" 
set title  offset character 0, 0, 0 font "" norotate
set timestamp bottom 
set timestamp "" 
set timestamp  offset character 0, 0, 0 font "" norotate
set rrange [ * : * ] noreverse nowriteback  # (currently [8.98847e+307:-8.98847e+307] )
set trange [ * : * ] noreverse nowriteback  # (currently ["":""] )
set urange [ * : * ] noreverse nowriteback  # (currently ["":""] )
set vrange [ * : * ] noreverse nowriteback  # (currently [-10.0000:10.0000] )
set xlabel "" 
set xlabel  offset character 0, 0, 0 font "" textcolor lt -1 norotate
set x2label "" 
set x2label  offset character 0, 0, 0 font "" textcolor lt -1 norotate
#set xrange [ * : * ] noreverse nowriteback  # (currently ["":""] )

set xrange [ "${timefrom}" : * ]

set x2range [ * : * ] noreverse nowriteback  # (currently [3.23624e+08:3.23624e+08] )
set ylabel "" 
set ylabel  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set y2label "" 
set y2label  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set yrange [ 0 : * ] noreverse nowriteback  # (currently [70.0000:80.0000] )
set y2range [ * : * ] noreverse nowriteback  # (currently [74.2500:75.7500] )
set zlabel "" 
set zlabel  offset character 0, 0, 0 font "" textcolor lt -1 norotate
set zrange [ * : * ] noreverse nowriteback  # (currently [-10.0000:10.0000] )
set cblabel "" 
set cblabel  offset character 0, 0, 0 font "" textcolor lt -1 rotate by -270
set cbrange [ * : * ] noreverse nowriteback  # (currently [8.98847e+307:-8.98847e+307] )
set zero 1e-08
set lmargin  8
set bmargin  7
set rmargin  -1
set tmargin  -1
set locale "de_DE.UTF-8"
set pm3d explicit at s
set pm3d scansautomatic
set pm3d interpolate 1,1 flush begin noftriangles nohidden3d corners2color mean
set palette positive nops_allcF maxcolors 0 gamma 1.5 color model RGB 
set palette rgbformulae 7, 5, 15
set colorbox default
set colorbox vertical origin screen 0.9, 0.2, 0 size screen 0.05, 0.6, 0 front bdefault
set loadpath 
set fontpath
set fit noerrorvariables
GNUTERM = "x11"

set xtics rotate by -35
set format x "%Y/%m/%d"
plot "$logfile" using 1:$((x+2)) with lines title "${columns[$((x))]//_/ }" lw 1.5 lt 6, \
     "$logfile" using 1:$((x+3)) with lines title "${columns[$((x+1))]//_/ }" lw 1.5 lt 5
#    EOF

THEGNUPLOTSCRIPTHERE

	convert -alpha on -negate -density 300 -geometry $OUTPUTSIZE $PLOTBASE-$scope-$x.ps $PLOTBASE-$scope-$x.png
	cp $PLOTBASE-$scope-$x.png $WEBDIR

done




# generate the index page

hscope=${scope/all/}

cat <<THEINDEXHEADER > $PLOTDIR/kw${hscope}.php
<?php
include("../private/header.php");
?>

<h1>Gentoo ebuild statistics</h1>
<a href="kw.php">all time</a> - <a href="kwyear.php">last year</a> - <a href="kwmonth.php">last month</a><br><br>

  <img src='kwplot-${scope}-major.png'><br>
  <img src='kwplot-${scope}-prefix.png'><br>
  <img src='kwplot-${scope}-freebsd.png'><br>
  <img src='kwplot-${scope}-0.png'><br>
THEINDEXHEADER


for ((x=1; x<${#columns[*]}; x+=2)); do
  echo "  <img src='kwplot-${scope}-$x.png'><br>"            >> $PLOTDIR/kw${hscope}.php
done


cat <<THEINDEXFOOTER >> $PLOTDIR/kw${hscope}.php

<?php
include("../private/footer.php");
?>
THEINDEXFOOTER

cp $PLOTDIR/kw${hscope}.php $WEBDIR

