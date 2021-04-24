file = 'p6_1.dat'

set y2tics 1e-4,1e1
set ytics nomirror

set xlabel "{/:=14 N}"
set ylabel "{/:=14 Energy [eV]}"
set y2label "{/:=14 Run time [s]}"

set logscale x 10
set logscale y2 10

plot file using 1:2 with linespoints pointtype 6 pointsize 1.5 linecolor "red" title 'Energy' axis x1y1,\
	 file using 1:3 with linespoints pointtype 3 pointsize 1.5 title 'Time' axis x1y2
