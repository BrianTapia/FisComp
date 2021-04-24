file = 'fort.67'

set xrange [-0.1:3.24]
set yrange [1e-2:1e1]

unset log x 
set log y 10

set xlabel "{/:=14 x}"
set ylabel "{/:=14 Error Relativo}"

l(x) = (x**11)/11 - (5*(x**3))/3 + 1

unset arrow
#set arrow from 0,1.01 to 3.1415926535897932,1.01 nohead lc "black" lw 2


plot file using 1:4 with linespoints pt 7 ps 0.5 lc "red" title 'Runge-Kutta',\
     #l(x) title 'Analítica'
