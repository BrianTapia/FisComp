file = 'fort.66'

set xrange [1: 1000]

set log x 10
set log y 10

set xlabel "{/:=14 Error Relativo }"
set ylabel "{/:=14 Tiempo de Ejecución}"


plot file using 4:2 with linespoints pt 7 ps 0.5 lc "red" title 'Simpson'
plot file using 5:3 with linespoints pt 7 ps 0.5 title 'Gauss-Legendre'
