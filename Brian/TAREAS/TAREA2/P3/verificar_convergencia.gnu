file = 'fort.65'

set border lw 2

unset log x 
set log x 10

set xlabel "{/:=14 N}"
set ylabel "{/:=14 I}"

plot file using 1:2 w l lw 1.7 title 'Valor de la integral',\
     #l(x) title 'Analítica'
