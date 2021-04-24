file = 'espacio_phi.dat'

unset log x 
unset log y 

set xlabel "{/:=14 p1 }"
set ylabel "{/:=14 p2}"

#l(x) = (x**11)/11 - (5*(x**3))/3 + 1

#unset arrow
#set arrow from 0,1.01 to 3.1415926535897932,1.01 nohead lc "black" lw 2


plot file using 2:3 w l lw 0.7 title 'Runge-Kutta'
     #l(x) title 'Analítica' lw 2
