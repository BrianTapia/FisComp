file = 'relativeerr.dat'

set xlabel "{/:=14 𝛿 }"
set ylabel "{/:=14 Relative Error}"

set logscale x 10
set logscale y 10

plot file using 1:2 with linespoints pointtype 4 pointsize 1.5 linecolor "red" title 'Error'
