file = 'fort.66'

set xrange [-0.1:3.24]
set yrange [1e-2:1e1]

unset log x 
set log y 

set xlabel "{/:=14 θ max [rad] }"
set ylabel "{/:=14 T/T0}"

unset arrow
set arrow from 0,1.01 to 3.1415926535897932,1.01 nohead lc "black" lw 2

plot file using 1:2 with linespoints pt 7 ps 0.5 lc "red" title 'Simpson',\
     #file using 1:3 with linespoints pt 7 ps 0.5 title 'Gauss-Legendre',
