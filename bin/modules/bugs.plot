#!/bin/bash

source ${moddir}/bugs.config

for ((x=0; x<${#URLs[*]}; x++)); do
gnuplot &> /dev/null <<THEGNUPLOTSCRIPTHERE

set terminal postscript eps noenhanced defaultplex \
   leveldefault color colortext \
   solid dashlength 1.0 linewidth 1.0 butt noclip \
   palfuncparam 2000,0.003 \
   "Helvetica" 17
set output "$webdir/bugs/b-$scope-$x.ps"
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
set ytics 50 norangelimit
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

set xrange [ ${timefrom} : ${now} ]

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
set lmargin  5
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
plot "$DATA" using 1:$((x+2)) with lines title "${NAMEs[$x]}" lw 1.5 lt 5
#    EOF

THEGNUPLOTSCRIPTHERE

	convert -alpha on -negate -density 300 -geometry $OUTPUTSIZE $PLOTBASE-$scope-$x.ps $PLOTBASE-$scope-$x.png
	cp $PLOTBASE-$scope-$x.png $WEBDIR

done

webname=${name/all/index}

cat <<THEINDEXHEADER > $PLOTDIR/${webname}.php
<?php
include("../private/header.php");
?>

<h1>Gentoo bug statistics</h1>
<a href="index.php">all time</a> - <a href="year.php">last year</a> - <a href="month.php">last two months</a><br>

THEINDEXHEADER

for ((x=0; x<${#PAGEORDER[*]}; x++)); do
  NORMALURL=${URLs[${PAGEORDER[$x]}]/ctype=csv//}
  HTTPSURL=${NORMALURL/http:/https:}

  echo "<a href='${HTTPSURL}' target='_blank'>"             >> $PLOTDIR/${webname}.php
  echo "  <img src='plot-${name}-${PAGEORDER[$x]}.png'>"    >> $PLOTDIR/${webname}.php
  echo "</a><br>"                                           >> $PLOTDIR/${webname}.php
done

cat <<THEINDEXFOOTER >> $PLOTDIR/${webname}.php

<?php
include("../private/footer.php");
?>
THEINDEXFOOTER

cp $PLOTDIR/${webname}.php $WEBDIR

done
