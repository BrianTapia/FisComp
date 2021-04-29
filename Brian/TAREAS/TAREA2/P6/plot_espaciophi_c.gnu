file = 'espacio_phi_c.dat'

unset log x 
unset log y 

set xlabel "{/:=14 φ_1 }"
set ylabel "{/:=14 φ_2}"

set title "{/:=14 Espacio φ"

#l(x) = (x**11)/11 - (5*(x**3))/3 + 1

#unset arrow
#set arrow from 0,1.01 to 3.1415926535897932,1.01 nohead lc "black" lw 2


plot file using 2:3 w l lw 0.7 lc "orange" title 'Trayectoria'
     #l(x) title 'Analítica' lw 2
