file = 'fort.68'

set xrange [-0.1:3.24]
set yrange [1e-2:1e1]

unset log x 
unset log y 

set xlabel "{/:=14 x }"
set ylabel "{/:=14 f(x)}"

l(x) = (0.2)*exp(-(2*x))*(5*cos(5*x) + 2*(sin(5*x)))

unset arrow


plot file using 1:2 with linespoints pt 7 ps 0.75 lc "red" title 'Runge-Kutta',\
     l(x) title 'Analítica' lw 2.5
