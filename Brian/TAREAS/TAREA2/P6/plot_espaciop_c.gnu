file = 'espacio_p_c.dat'

unset log x 
unset log y 

set xlabel "{/:=14 p_1 }"
set ylabel "{/:=14 p_2}"

set title "{/:=14 Espacio p"

#l(x) = (x**11)/11 - (5*(x**3))/3 + 1

#unset arrow
#set arrow from 0,1.01 to 3.1415926535897932,1.01 nohead lc "black" lw 2


plot file using 2:3 w l lw 0.7 lc "dark-orange" title 'Trayectoria'
     #l(x) title 'Analítica' lw 2
