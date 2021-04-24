file = 'p5_2.dat'

set y2tics 0.09,0.01
set ytics nomirror

set xlabel "{/:=14 x }"
set ylabel "{/:=14 f(x)}"

set y2label "{/:=14 Razón}"

set y2range [0.9999999:1.0000001]

set title 'Doble precisión'

!set logscale x 10
unset logscale x
set logscale y 10
unset logscale y
unset logscale y2


plot file using 1:2 with linespoints pointtype 4 pointsize 1.5 linecolor "red" title 'Cálculo directo' axis x1y1,\
     file using 1:3 with linespoints pointtype 4 pointsize 1.5 linecolor "blue" title 'Cálculo indirecto' axis x1y1,\
     file using 1:4 with linespoints pointtype 7 pointsize 1   linecolor "green" title 'Razón' axis x1y2
