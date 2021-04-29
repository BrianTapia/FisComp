file = 'fort.67'

set border lw 2

unset log x 
set log y 10

set xlabel "{/:=14 z}"
set ylabel "{/:=14 V(z)}"

plot file using 1:2 w l lw 1.7 title 'Potencial',\
     #l(x) title 'Analítica'
