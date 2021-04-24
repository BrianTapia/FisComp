file = 'fort.66'

set xrange [1: 1000]

set log x 10
set log y 10

set xlabel "{/:=14 N }"
set ylabel "{/:=14 Error Relativo}"

set arrow from 0,3.6275987284 to 1000,3.6275987284 nohead lc "black" 

plot file using 1:2 with linespoints pt 7 ps 0.5 lc "red" title 'Simpson',\
     file using 1:3 with linespoints pt 7 ps 0.5 title 'Gauss-Legendre',
