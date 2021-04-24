file = 'fort.68'

set xrange [-0.1:3.24]
set yrange [1e-2:1e1]

unset log x 
set log y 10

set xlabel "{/:=14 x}"
set ylabel "{/:=14 Error Relativo}"

unset arrow


plot file using 1:4 with linespoints pt 7 ps 0.5 lc "red" title 'Runge-Kutta',\

