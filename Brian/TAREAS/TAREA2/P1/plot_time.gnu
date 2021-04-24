file = 'fort.66'

set xrange [1: 1000]

set log x 10
set log y 10

set xlabel "{/:=14 N }"
set ylabel "{/:=14 Tiempo de Ejecución}"

set arrow from 0,3.6275987284 to 1000,3.6275987284 nohead lc "black" 

plot file using 1:4 with linespoints pt 7 ps 0.5 lc "red" title 'Simpson',\
     file using 1:5 with linespoints pt 7 ps 0.5 title 'Gauss-Legendre',
