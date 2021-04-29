file = 'espacio_real.dat'

set xlabel "{/:=14 x }"
set ylabel "{/:=14 y}"

set title "{/:=14 Espacio cartesiano"


plot file using 2:3 w l lw 0.2 lc "red" title 'Trayectoria',\
     file using 4:5 w l lw 0.2 lc "red" title 'Trayectoria'
